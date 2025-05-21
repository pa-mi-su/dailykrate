FROM eclipse-temurin:17-jdk

RUN apt-get update && apt-get install -y unzip

WORKDIR /app

COPY target/discovery-server-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8086

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
