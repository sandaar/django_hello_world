FROM python:3.6.1

RUN pip install Django==1.10.6 gunicorn==19.7.1
RUN mkdir /src
WORKDIR /src
