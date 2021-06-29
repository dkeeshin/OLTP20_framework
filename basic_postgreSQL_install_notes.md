__Basic PostgreSQL-13 on Linux Mint Notes__

__Run the following commands as "root"__:

		sudo apt-get install wget ca-certificates

		wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add –

__NOTE: Replace “bionic” with appropriate UBUNTU CODENAME for your version.  To see the code name:__

		cat /etc/os-release | grep UBUNTU_CODENAME

		sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

		sudo apt-get update

		sudo apt-get -y install postgresql-13
