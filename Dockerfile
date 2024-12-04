FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /journal_app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-alpine
WORKDIR /journal_app
EXPOSE 8080

COPY --from=build /journal_app/Backend_User/target/*.jar /journal_app/

ENV SPRING_DATASOURCE_PASSWORD=admin
ENV SPRING_DATASOURCE_USERNAME=admin
ENV SPRING_DATASOURCE_URL=jdbc:mysql://host.docker.internal:3307/DB_Journal

CMD ["sh", "-c", "java -jar /journal_app/Backend_User-0.0.1-SNAPSHOT.jar && java -jar /journal_app/Backend_User-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
