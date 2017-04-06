if [ -f /lb_app ]; then
  mkdir /lb_app;
else
  rm -rf /lb_app/*
fi
cp -r /nginx/* /lb_app

if [[ $(docker ps -a --filter="name=app-nginx" | wc -l) -gt 1 ]]; then
    echo "app-nginx container already present" 
else
    docker run -d --name app-nginx -p 80:80 -v /lb_app/conf.d/:/etc/nginx/conf.d/ -v /lb_app:/lb_app nginx 
fi


