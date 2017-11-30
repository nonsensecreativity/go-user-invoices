sudo docker run -d -it \
                -p 10:9000 \
                --name portainer \
                --restart always \
                -v '/var/run/docker.sock:/var/run/docker.sock' \
                portainer/portainer

