# docker-supervisor
Dockerfile for running Python projects under [Supervisor](http://supervisord.org) in a Docker container.

### Details:
Base image: [`praekeltfoundation/python-base`](https://hub.docker.com/r/praekeltfoundation/python-base/)

This is a Debian Jessie base image with the latest version of Python 2 as well as some customizations to make the installation of our Python software simpler.

The latest version of Supervisor is installed using `pip`, rather than using the package in the Debian repos.

### Usage:
Copy your Supervisor config files (with the extension `.conf`) containing your program definitions into `/etc/supervisord.d` in the container.

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
ADD ./openvpn.conf /etc/supervisord.d/openvpn.conf
```

And that's it!

**NOTE:** You should include those `stdout_XX` and `stderr_XX` lines in every program definition so that the output of those programs are written to stdout/stderr and can be accessed via `docker logs`.

`supervisorctl` is also available. It is best accessed via:
```
docker exec -it <container-id> supervisorctl
```
