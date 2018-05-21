# docker-supervisor

[![Docker Pulls](https://img.shields.io/docker/pulls/praekeltfoundation/supervisor.svg)](https://hub.docker.com/r/praekeltfoundation/supervisor/)
[![Build Status](https://travis-ci.org/praekeltfoundation/docker-supervisor.svg?branch=master)](https://travis-ci.org/praekeltfoundation/docker-supervisor)
[![Requirements Status](https://pyup.io/repos/github/praekeltfoundation/docker-supervisor/shield.svg)](https://pyup.io/repos/github/praekeltfoundation/docker-supervisor/)

Dockerfile for running Python projects under [Supervisor](http://supervisord.org) in a Docker container.

### Details:
Base image: [`praekeltfoundation/python-base`](https://hub.docker.com/r/praekeltfoundation/python-base/)

These are base images with the latest version of Python 2 as well as some customizations to make the installation of our Python software simpler.

The latest version of Supervisor is installed using `pip`, rather than using the package in the Debian repos in order to avoid installing extra dependencies (such as two Pythons).

We use the config paths from the Debian Supervisor package rather than Supervisor's defaults. i.e. `/etc/supervisor/supervisor.conf` rather than `/etc/supervisord.conf` for the main config file and `/etc/supervisor/conf.d/*.conf` rather than `/etc/supervisor.d/*.conf` for extra config files. Generally, people are more familiar with working with this configuration after having used Debian/Ubuntu systems.

### Usage:
Copy your Supervisor config files (with the extension `.conf`) containing your program definitions into `/etc/supervisor/conf.d` in the container.

For example:  
`./openvpn.conf`:
```ini
[program:openvpn]
command=/usr/sbin/openvpn --writepid /run/openvpn/client.pid
    --status /run/openvpn/client.status 10 --config /etc/openvpn/client.conf
directory=/etc/openvpn
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

`./Dockerfile`:
```dockerfile
FROM praekeltfoundation/supervisor
ADD ./client.conf /etc/openvpn/client.conf
ADD ./openvpn.conf /etc/supervisor/conf.d/openvpn.conf
```

And that's it!

**NOTE:** You should include those `stdout_XX` and `stderr_XX` lines in every program definition so that the output of those programs are written to stdout/stderr and can be accessed via `docker logs`.

`supervisorctl` is also available. It is best accessed via:
```
docker exec -it <container-id> supervisorctl
```
