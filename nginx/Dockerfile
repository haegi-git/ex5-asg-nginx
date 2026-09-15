FROM nginx:1.31.3-alpine
# 기본 conf 지우고 프록시 설정으로 교체. 안 하면 /app/ 이 FastAPI 로 안 감
RUN rm /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./html/ /usr/share/nginx/html
EXPOSE 80