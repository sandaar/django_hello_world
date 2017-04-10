if [ -f /lb_app ]; then
  mkdir /lb_app;
else
  rm -f /lb_app/*
fi

if [[ $(docker ps -a --filter="name=app-nginx" | wc -l) -gt 1 ]]; then
    cp /nginx/* /lb_app
    echo "app-nginx container already present" 
else
    cp -r /nginx/* /lb_app
    docker run -d --name app-nginx -p 80:80 -v /lb_app/conf.d/:/etc/nginx/conf.d/ -v /lb_app:/lb_app nginx 
fi


