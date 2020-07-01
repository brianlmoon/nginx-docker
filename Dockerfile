FROM nginx:1.17

RUN apt-get update && \
    apt install -y python-certbot-nginx && \
    rm -r /var/lib/apt/lists/* && \
    apt autoremove -y
