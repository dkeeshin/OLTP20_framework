/*
 *
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// Package main implements a server for Greeter service.
package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	"os"

	oltp20 "github.com/dkeeshin/OLTP20_framework/proto"
	"google.golang.org/grpc"
)

type server struct {
	oltp20.UnimplementedOLTP20ServiceServer
}

var data *oltp20.StageLocation //create a hub_peer_group slice
var connection_string string

func (s *server) LocationNotification(ctx context.Context, in *oltp20.StageLocation) (*oltp20.LocationStatus, error) {
	log.Printf("Received: %v", in.GetName())

	log.Printf(string(in.Locationid), in.Name, in.Latitude, in.Longitude)
	db_connect(in)

	return &oltp20.LocationStatus{Status: "received " + in.Name}, nil
}

func db_connect(d *oltp20.StageLocation) {

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

	connection_string = fmt.Sprintf("dbname=%s host=%s user=%s port=%s password=%s sslmode=disable", g.oltp_db, g.db_host, g.db_user, g.db_port, g.db_password)
	// uncomment for remote connection
	conn, err := pgx.Connect(context.Background(), connection_string)

	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}


	fmt.Println("locationid:", d.Locationid)
	fmt.Println("Name:", d.Name)
	fmt.Println("Latitude:", d.Latitude)
	fmt.Println("Longitude:", d.Longitude)

	// uncomment for remote updates
	if _, err := conn.Exec(context.Background(), "CALL reference.up_add_location($1, $2, $3, $4)", d.Locationid, d.Name, d.Latitude, d.Longitude); err != nil {
		// Handling error, if occur
		fmt.Println("Unable to insert due to: ", err)
	}
	

	return
}

func main() {

	//get  port number from command line
	wordPtr := flag.String("host", "localhost:50052", "default host to listen on")
	flag.Parse()
	host := *wordPtr
	println("OLTP20 Message Server listening on host:" + host)

	lis, err := net.Listen("tcp", host)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	oltp20.RegisterOLTP20ServiceServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

}
