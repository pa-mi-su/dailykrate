FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/data-service-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 9002

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
