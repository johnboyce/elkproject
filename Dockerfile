FROM quay.io/quarkus/ubi-quarkus-native-image:22.3-java17
COPY target/*-runner /app/application
EXPOSE 8080
CMD ["/app/application", "-Dquarkus.http.host=0.0.0.0"]
