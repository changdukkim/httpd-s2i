FROM apache:2.4.39

LABEL io.k8s.description="Platform for serving static files" \
      io.k8s.display-name="Apache httpd 2.4" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,http,http24,apache,httpd,rhscl-httpd24"

COPY files/s2i/ /usr/local/s2i

RUN useradd -u 1000 -G root apache \
  && chmod 775 /usr/local/s2i/* \
  && chmod -R 775 /usr/local/apache2 \
  && chown -R apache:root /usr/local/apache2 

# 8080 포트를 오픈한다.
EXPOSE 8080

USER 1000
 
# 실행명령
CMD ["apachectl","-k","start","-D","FOREGROUND"]
