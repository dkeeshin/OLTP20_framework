package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"os"
	"time"

	oltp20 "github.com/dkeeshin/OLTP20_framework/proto"
	"github.com/jackc/pgx/v4"
	"github.com/lib/pq"
	"google.golang.org/grpc"
)

type Data struct{ IP string } //structure for mapping table to slice
var hub_peer_group []Data     //create a hub_peer_group slice
var slice_count int

const shortDuration = 1 * time.Millisecond

//structure for passing stage.location
type StageLocation struct {
	Locationid string
	Name       string
	Latitude   string
	Longitude  string
}

func waitForNotification(l *pq.Listener) {
	for {
		select {
		case n := <-l.Notify:
			fmt.Println("Received data from channel [", n.Channel, "] :")
			var foo string
			foo = n.Extra

			if foo == "" {
				fmt.Println("Nothing to process")
				return
			}

			fmt.Println("In process: ", n.Extra)

			fmt.Println("Shuffling hub_peer_group ips...")
			//shuffle hub_peer_group ips
			ip_shuffle()

			fmt.Println("Broadcasting to peer ips...")
			slice_count = len(hub_peer_group)
			broadcast_grpc_message(foo, slice_count)
			//for testing
			//grpc_message(foo, "localhost:50052", false)

			return
		case <-time.After(90 * time.Second):
			fmt.Println("Received no events for 90 seconds, checking connection")
			go func() {
				l.Ping()
			}()
			return
		}
	}
}

func broadcast_grpc_message(message string, message_count int) {

	message_counter := 1
	for _, i := range hub_peer_group {

		color_reset := "\033[0m"
		red := "\033[31m"

		conn, err := grpc.Dial(i.IP, grpc.WithInsecure())
		if err != nil {
			log.Printf("did not connect: %v", err)
		}

		defer conn.Close()

		c := oltp20.NewOLTP20ServiceClient(conn)
		ctx, cancel := context.WithTimeout(context.Background(), time.Second)
		defer cancel()

		var stagelocation StageLocation
		json.Unmarshal([]byte(message), &stagelocation)
		r, err := c.LocationNotification(ctx, &oltp20.StageLocation{Locationid: stagelocation.Locationid, Name: stagelocation.Name, Latitude: stagelocation.Latitude, Longitude: stagelocation.Longitude})

		if err != nil {
			log.Printf(red+"oops--cannot connect--", err, color_reset)

		} else {
			fmt.Println("Destination IP: ", i.IP, message_counter)
			log.Printf("Server Message Sent : %s", r.Status)
		}
		// last one
		if message_counter == message_count {
			connection_string := db_get_connection_string()
			conn2, err := pgx.Connect(context.Background(), connection_string)

			if err != nil {
				fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
				os.Exit(1)
			}
			if _, err := conn2.Exec(context.Background(), "CALL reference.up_add_location($1, $2, $3, $4)", stagelocation.Locationid, stagelocation.Name, stagelocation.Latitude, stagelocation.Longitude); err != nil {
				// Handling error, if occur
				fmt.Println("Unable to insert due to: ", err)
			}
			return
		}
		message_counter++
	}
	return
}

func ip_shuffle() {
	shuffle := 1 //number of shuffles
	for i := 1; i <= shuffle; i++ {
		rand.Seed(time.Now().Unix())
		rand.Shuffle(len(hub_peer_group), func(i, j int) {
			hub_peer_group[i], hub_peer_group[j] = hub_peer_group[j], hub_peer_group[i]
		})
		fmt.Println(hub_peer_group)
	}

	return
}

func db_get_peer_group(connection_string string) {

	conn, err := pgx.Connect(context.Background(), connection_string)

	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}

	rows, _ := conn.Query(context.Background(), "SELECT ip from setup.uf_get_peer_group_ip();")
	var ip string
	for rows.Next() {
		err := rows.Scan(&ip)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
			os.Exit(1)
		}
		hub_peer_group = append(hub_peer_group, Data{ip})
	}

	defer conn.Close(context.Background())

	return
}

func db_get_connection_string() string {
	var connection_string string
	type Environment struct {
		oltp_db     string
		db_user     string
		db_host     string
		db_port     string
		db_password string
	}

	var g Environment //need to add the following variables to etc/environment file
	g.oltp_db = os.Getenv("OLTP20DB")
	g.db_user = os.Getenv("DBUSER")
	g.db_host = os.Getenv("DBHOST")
	g.db_port = os.Getenv("DBPORT") //has to be string
	g.db_password = os.Getenv("DBPASSWORD")

	connection_string = fmt.Sprintf("dbname=%s host=%s user=%s port=%s password=%s sslmode=disable ", g.oltp_db, g.db_host, g.db_user, g.db_port, g.db_password)
	return (connection_string)
}

func main() {

	connection_string := db_get_connection_string()
	db_get_peer_group(connection_string)

	reportProblem := func(ev pq.ListenerEventType, err error) {
		if err != nil {
			fmt.Println(err.Error())
		}
	}
	listener := pq.NewListener(connection_string, 0*time.Second, time.Minute, reportProblem)
	err := listener.Listen("events")
	if err != nil {
		panic(err)
	}
	fmt.Println("Listening for PostgreSQL Notifications...")
	for {
		waitForNotification(listener)
	}

}
