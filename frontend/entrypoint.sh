#!/bin/sh
sed -i "s|__BACKEND_URL__|${BACKEND_URL}|g" /usr/share/nginx/html/index.html
exec nginx -g "daemon off;"
