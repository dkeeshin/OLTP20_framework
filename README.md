__OLTP 2.0 Framework Idea__
__2021-06-10__

__DESCRIPTION__
The following is a conceptual design with simple proof of concept code work. 

__IDEA__:

Using best of breed, open-source components, design a framework for building an open source, peer-to-peer OLTP “data network”.

__FRAMEWORK__:

A “Database Everywhere” Approach.

A data-event-driven, permissioned network of databases for near real time use.

Each node has a database.

Treat each database transaction as an asynchronous message. 

Achieve reasonable and eventual data consistency.

Factor distances and speeds between nodes into the design and transaction process.  Use a regional ‘hub’ approach to balance performance, security, and monitoring.
 
Keep data sets small and immutable.   AKA ‘inserts only”.  (yes, it could be *****chain like)

Make it easy to understand, use, maintain, and customize.  

Use Cases

1.	Trading Systems 
2.	Payments
3.	Business Intelligence (BI)- Data Vault
4.	Business to Business E-Commerce 

Here is an example of using a database transaction as an asynchronous message. The message is sent over a gRPC connection to a remote database node.

First I create a local postgresql database and schema to store messages.  Startin Linux by firing up postgres:

$ sudo -u postgres psql -p 5432 

Then run https://github.com/dkeeshin/OLTP20_framework/blob/main/postgreSQL/0001create_oltp20_framework.sql
from the postgres command line:

		postgres=# \i /Documents\0001create_oltp20_framework.sql

If all is ok, the above command will create a database called oltp20_framework.  And connect you to it.
Next run this script https://github.com/dkeeshin/OLTP20_framework/blob/main/postgreSQL/0002create_outgoing.sql using the command:

		oltp20_framework=# \i 0002create_outgoing.sql

Here I create a trigger on the message.outgoing table. This trigger fires off a notification.  I am using postgreSQL LISTEN and NOTIFY features to do this.

Meanwhile, I need the local GO code listening for the notification from postgreSQL. First, make sure this GO code is in place:

https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/main.go

GO can be finicky about where it runs from.  I model the GO code here on the "HelloWorld" examples in https://grpc.io/docs/languages/go/quickstart/
Follow the instructions in the quickstart and you'll end up with directory like 

/grpc-go/examples/helloworld

I would recommend creating directory  called message_client in helloworld and put the main.go above in it.  Similarily,  I would do the same for GO code for the gRPC server 

https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/main.go

Once the GO code is in place you'll need to start up the listeners.  First run this:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/01_message_client.png)

Followed by:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/02_message_server.png)

Once the GO code receives a message from postgreSQL,  I want it to send a message over gRPC to a remote connection.  Before I can do that I need to start up the remote connection:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/01_message_client.png)

GO code sends message over gRPC to a remote server.  

Current tools of choice:  Linux, PostgreSQL, GO(GOlang) and gRPC.

Software Used

https://linuxmint.com/
https://www.postgresql.org/
https://golang.org/doc/install
https://grpc.io/docs/languages/go/quickstart/
https://code.visualstudio.com/

insert into message.outgoing (type, date, payload) values ('greeting', '2021-06-10', 'Ah-Ha!');








