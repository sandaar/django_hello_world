docker run --name hello_world_django -d -p 8000:8000 -v /webapp:/hello_world_django quay.io/sandaar/django_unicorn:v1 /bin/sh -c 'cd /hello_world_django/hello_world_django; ../start.sh' 