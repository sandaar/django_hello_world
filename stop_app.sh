if [[ $(docker ps -a --filter="name=hello_world_django" | wc -l) -gt 1 ]]; then
    CONTAINER_ID=$(docker ps -a --filter="name=hello_world_django" | tail -n1 | awk '{ print $1 }')
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
else
    echo "good to go, container not present"
fi
