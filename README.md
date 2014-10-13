Docker container with nginx with autoreloader


run with:
docker run -d -p 80:80 --dns 8.8.8.8 --dns 8.8.4.4 -v /etc/nginx/sites-enabled:/var/nginx/sites_enabled  oniram88/nginx-autoreload:1.6.0