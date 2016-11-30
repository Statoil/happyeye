from nginx

RUN rm -r /usr/share/nginx/html
COPY index.html above.png below.png average.png above12.png below12.png average12.png /usr/share/nginx/html/

RUN rm /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY start_nginx.sh /usr/bin
CMD /usr/bin/start_nginx.sh

EXPOSE 80
