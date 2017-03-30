if [[ $(docker ps -a --filter="name=hello_world_django" | wc -l) -gt 1 ]]; then
    echo "hello_world_django container already present"
else
    docker run --name hello_world_django -d -p 8000:8000 -v /webapp:/src quay.io/sandaar/django_unicorn:v2 /bin/sh -c 'cd /src/hello_world_django; ../start.sh'
fi
if [[ $(docker ps -a --filter="name=app-nginx" | wc -l) -gt 1 ]]; then
    echo "app-nginx container already present"
else
    docker run -d --name app-nginx -p 80:80 --link hello_world_django:backend -v /webapp/nginx/:/etc/nginx/conf.d/ nginx 
fi


