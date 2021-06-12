__OLTP 2.0 Framework Idea__
__2021-06-10__

__DESCRIPTION__
The following is a conceptual design and preliminary a proof of concept code sample. 

__CONCEPT__:

Using best of breed, open-source components, design a framework for building an open source, peer-to-peer OLTP “data network”.

__REQUIREMENTS__:

A “Database Everywhere” Approach.

A data-event-driven, permissioned network of databases for near real time use.

Each node has its' own database.

Treat each database transaction as an asynchronous message. 

Achieve reasonable and eventual data consistency.

Factor distances and speeds between nodes into the design.  

Use a regional ‘hub’ approach to balance performance, security, and monitoring.
 
Keep data sets small and immutable.   AKA ‘inserts only”.  (yes, it could be b-chain like)

Make it easy to understand, use, maintain, and customize.  

**USE CASES**

1.	Trading Systems 
2.	Payments
3.	Data Vaults 

**CODE SAMPLE**

The following is an example of using a database transaction as an asynchronous message. The message is sent over a gRPC connection to a remote database node.

**TOOLS OF CHOICE**

Linux, PostgreSQL, GO(GOlang) and gRPC.

For information and instruction on how to install these components, see:

https://linuxmint.com/

https://www.postgresql.org/

https://golang.org/doc/install

https://grpc.io/docs/languages/go/quickstart/

https://code.visualstudio.com/

**SET UP**

Step one is to create a local postgresql database and schema to store messages.  In Linux, 

$ sudo -u postgres psql -p 5432 

From the postgres command line, run https://github.com/dkeeshin/OLTP20_framework/blob/main/postgreSQL/0001create_oltp20_framework.sql

		postgres=# \i /Documents\0001create_oltp20_framework.sql

The above script creates a database called __oltp20_framework__.  And connects to it. 
Next run  https://github.com/dkeeshin/OLTP20_framework/blob/main/postgreSQL/0002create_outgoing.sql using this command:

		oltp20_framework=# \i 0002create_outgoing.sql

This script contains a trigger on the __message.outgoing__ table. This trigger fires off a notification using postgreSQL' LISTEN and NOTIFY feature.

Meanwhile, start the local GO code that "listens" for the notifications from postgreSQL. First, make sure this GO code is in place:

https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/main.go

NOTE: GO can be finicky about where it runs from.  I model the GO code here on the "HelloWorld" examples in https://grpc.io/docs/languages/go/quickstart/
Follow the instructions in the quickstart and you'll end up with directory like 

/grpc-go/examples/helloworld

I would recommend creating directory  called message_client in helloworld and put the main.go above in it.  Similarily,  I would do the same for GO code for the gRPC server 

https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/main.go

If there are issues,  be sure to check the linux path command.

Once the GO code is in place start up the listener. Run this:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/01_message_client.png)

Followed by:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/02_message_server.png)

Once the GO code receives a message from postgreSQL,  I send it as a message over gRPC to a remote connection.  Before I can do that I need to start up the remote connection:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/01_message_client.png)

GO code sends message over gRPC to a remote server.  

insert into message.outgoing (type, date, payload) values ('greeting', '2021-06-10', 'Ah-Ha!');








