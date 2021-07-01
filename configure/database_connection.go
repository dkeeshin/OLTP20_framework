package database_connection

import (
	"fmt"
	"os"
)

func connect() string {
	type Configuration struct {
		oltp_db     string
		db_user     string
		db_host     string
		db_port     string
		db_password string
	}

	var g Configuration

	g.oltp_db = os.Getenv("OLTP20DB")
	g.db_user = os.Getenv("DBUSER")
	g.db_host = os.Getenv("DBHOST")
	g.db_port = os.Getenv("DBPORT") //no int hass to be string
	g.db_password = os.Getenv("DBPASSWORD")

	connection_string := fmt.Sprintf("dbname=%s host=%s user=%s port=%s password=%s", g.oltp_db, g.db_host, g.db_user, g.db_port, g.db_password)

	return (connection_string)
}
