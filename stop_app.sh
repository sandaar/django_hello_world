if [[ $(docker ps -a --filter="name=some" | wc -l) -gt 1 ]]; then
    CONTAINER_ID=$(docker ps -a --filter="name=some" | tail -n1 | awk '{ print $1 }')
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
else
    echo "good to go, container not present"
fi
