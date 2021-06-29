__PostgreSQL-13 on Linux Mint/Ubuntu Install Notes__

__Run the following commands as "root"__:

		sudo apt-get install wget ca-certificates

		wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add –

__Get your Linux versions' UBUNTU_CODENAME:__

		cat /etc/os-release | grep UBUNTU_CODENAME

__In my case codename is "bionic". Add or change the codename in the following command__

		sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

__Update and Install__

		sudo apt-get update

		sudo apt-get -y install postgresql-13

__Alter PostgreSQL password__

        sudo -u postgres psql

        ALTER USER postgres PASSWORD 'NEWPASSWORD';
