## Nagios plugin for Docker

- prototype - not useful with current implementation
- uses image count as "performance data", with levels indicated as DATA_WARN|CRIT|MIN|MAX

### Installation in Ubuntu 13.10 (saucy):

Assumptions:

- have nagios3 properly installed (with the defaults)
- have docker properly installed (with the defaults)

Modify docker startup to also listen for tcp connection:

    # cat /etc/init/docker.conf 
    description     "Run docker"
    
    start on filesystem or runlevel [2345]
    stop on runlevel [!2345]
    
    respawn
    
    script
        /usr/bin/docker -H tcp://127.0.0.1:4243 -H unix:///var/run/docker.sock -d
    end script
    
As root:

    # cp {,/etc/nagios-plugins/config/}docker.cfg
    # cp {,/usr/lib/nagios/plugins/}check_docker

Add service to localhost nagios config:

    define service {
            use                             generic-service
            host_name                       localhost
            service_description             Custom Docker Checker In Bash
            check_command                   check_docker
    }

or

    # cp {,/etc/nagios3/conf.d/}localhost_nagios2.cfg

Restart nagios3

    # service nagios3 restart


###### Authored by Ho Ming Li @HoReaL

