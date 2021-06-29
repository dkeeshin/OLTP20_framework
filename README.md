__OLTP 2.0 Framework__
__2021-06-21__

__DESCRIPTION__

The following is a conceptual design and proof of concept code demo. 

__CONCEPT__

Using best of breed, open-source components, design a framework for building an open source, peer-to-peer OLTP “network of databases”.

__APPROACH__

A “database everywhere” approach with each peer having its' own database.

A data-event-driven, permissioned network of databases for near real time use.

Treat each database transaction as an asynchronous message. 

Achieve reasonable and eventual data consistency.

Factor distances and speeds between peers into the design.  

Use regional hubs to balance performance, security, and monitoring.
 
Borrow from the blockchain, make tranasctions immutable, AKA 'inserts only'.

Make it easy to understand, use, maintain, and customize.  

**USE CASES**

Anything that needs near real time high-performance, data management like trading systems, B2B E-Commerce, payments, blockchains, data vaults, etc. 

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/OLTP20Preliminary20210614.png)

**CODE SAMPLE**

The following is an example of using a database transaction as an asynchronous message. The message is sent over a gRPC connection to a destination database.

**COMPONENTS**

Linux, PostgreSQL, GO(GOlang) and gRPC.

For information and instruction on how to install these components, see:

https://linuxmint.com/

[PostgreSQL Install Guide](https://github.com/M-Thirumal/installation_guide/blob/master/PostgreSQL/Install_PostgresQL_in_Ubuntu.md)

https://golang.org/doc/install

https://grpc.io/docs/languages/go/quickstart/

https://github.com/git-guides/install-git

https://code.visualstudio.com/

**SET UP**

__GIT__

Start by cloning the git hub repository.  Assuming you have git installed, change, in linux to your home directory and run:

        git clone https://github.com/dkeeshin/OLTP20_framework.git

This will create a OLTP20_framework directory and a local version of the scripts for running this demo.

__PostgreSQL__

Next you'll need to create a local postgresql database and schema to store messages. Change to the /OLTP20_framework/postgreSQL directory and run:

		$ sudo -u postgres psql -p 5432 

From the postgres command line, run

		postgres=# \i 0001create_oltp20_framework.sql

The above script creates a database called __oltp20_framework__ and connects to it. Next run,

		oltp20_framework=# \i 0002create_outgoing.sql

This script creates the __message.outgoing__ table and adds a trigger called __message_notify_event__ to it. On a message insert to the table, this trigger fires off a notification using postgreSQLs' [LISTEN](https://www.postgresql.org/docs/9.1/sql-listen.html) and [NOTIFY](https://www.postgresql.org/docs/9.1/sql-notify.html) feature.

To exit out of postgreSQL and return to the linux command line prompt, type:

        oltp20_framework=# \q

__GO__

Assuming you have GO installed, change to the OLTP20_framework directory and run this
      
        export PATH=$PATH:/usr/local/go/bin

This will make sure there is a path to the GO program files.

Next you will need to edit the postgreSQL password and if necessary port number in main.go in the OLTP20_framework/message_client directory. You can use a text editor or Visual Studio code.  

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/07_client_main_go.png)

Next run the local GO code that "listens" for the notifications from postgreSQL. Change to the OLTP20_framework directory and run:
        
        go run message_client/message_client.go

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_client/01_message_client.png)

For a simulated remote connection, create a new terminal window and run:

        go run message_server/message_server.go

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/02_message_server.png)

**TESTING**

Create a third terminal window, start postgreSQL and execute this:

        insert into message.outgoing (type, date, payload) values ('message_test', '2021-06-29', 'Ah-Ha!');

You should now be able to see the inserted data, the data sent as a message from the client, and the message received by the server:

![image](https://github.com/dkeeshin/OLTP20_framework/blob/main/message_server/04_message_sent.png)

To be continued...







