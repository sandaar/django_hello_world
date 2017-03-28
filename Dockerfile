# Dockerfile

# FROM directive instructing base image to build upon
FROM python:3-onbuild

# COPY startup script into known file location in container
#RUN mkdir -p /hello_world_django/hello_world_django
#WORKDIR /hello_world_django/hello_world_django

# EXPOSE port 8000 to allow communication to/from server
EXPOSE 8000

# CMD specifcies the command to execute to start the server running.
CMD ["../start.sh"]
# done!
