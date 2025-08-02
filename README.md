# webserv sample static website
This static website is designed to test the 42 webserv project.

# Configuration
Edit the `docker-compose.yml` file and update the first item under volumes: with the absolute path to this cloned repository on your machine:
```yml
    volumes:
      - /ABSOLUTE/PATH/TO/REPO/:/app/
```

# Build the Docker Image
Make sure Docker is running, and build the docker image
```sh
open -g -a Docker
make build
```

# Run Docker container
```sh
make up
```

# Build and Run webserv
Launch an interactive shell to compile the webserv executable and run it using the sample.conf configuration file.
```sh
docker exec -it webserv bash
make
./webserv sample.conf
```
