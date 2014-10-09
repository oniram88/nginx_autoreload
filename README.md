Docker container with nginx with autoreloader


run with:
docker run -d -p 80:80 -v /etc/nginx/sites-enabled:/var/nginx_sites_enabled  oniram88/nginx-autoreload:1.6.0