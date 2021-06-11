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

I am using postgresql 13.   First I create a local database and schemas to store a message.


CREATE DATABASE oltp20_framework
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE SCHEMA message;

Trigger on message.outgoing table fires off notification to GO code that is listening for it.
GO code sends PostgreSQL message over gRPC to server

Current tools of choice:  Linux, PostgreSQL, GO(GOlang) and gRPC.


Software Used

https://linuxmint.com/
https://www.postgresql.org/
https://golang.org/doc/install
https://grpc.io/docs/languages/go/quickstart/
https://code.visualstudio.com/

Steps:

1. Create database and schemas. 
Postgresql/0001

2. Create table, trigger, and trigger function. 
Postgresql/0002

3. In Linux,  open a terminal, start client listener
 
4. Open a second terminal window.   Start server listener.  

grpc-go/examples/helloworld/message_client/main.go
grpc-go/examples/helloworld/message_server/main.go

5. Open a third terminal and insert message into message.outgoing table in postgres13.

Postgresql/0003
insert into message.outgoing (type, date, payload) values ('greeting', '2021-06-10', 'Ah-Ha!');








