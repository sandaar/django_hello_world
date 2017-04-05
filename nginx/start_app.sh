if [[ $(docker ps -a --filter="name=app-nginx" | wc -l) -gt 1 ]]; then
    echo "app-nginx container already present" 
else
    docker run -d --name app-nginx -p 80:80 -v /nginx/conf.d/:/etc/nginx/conf.d/ -v /nginx:/nginx nginx 
fi


