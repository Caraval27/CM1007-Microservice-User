# Step 1: Base image for MySQL
FROM mysql:8 AS db

# Set up environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=DB_Journal
ENV MYSQL_USER=admin
ENV MYSQL_PASSWORD=admin

# Copy the initial database script
COPY /Database.sql /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306

# Step 2: Build Spring Boot application
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /build_journal_app

# Copy the backend source files and build the application
COPY Backend_User/pom.xml .
COPY Backend_User/src ./src
RUN mvn clean package -DskipTests

# Step 3: Run MySQL and Spring Boot in the final container
FROM openjdk:17-jdk-alpine

# Copy the built Spring Boot application
WORKDIR /journal_app
COPY --from=build /build_journal_app/target/*.jar /journal_app/

# Copy the MySQL initialization script and data directory
COPY --from=db /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
COPY --from=db /var/lib/mysql /var/lib/mysql

# Set up environment variables for Spring Boot
ENV SPRING_DATASOURCE_PASSWORD=admin
ENV SPRING_DATASOURCE_USERNAME=admin
ENV SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/DB_Journal

# Expose both MySQL and Spring Boot ports
EXPOSE 3306
EXPOSE 8082

# Run MySQL and Spring Boot
CMD ["sh", "-c", "mysqld & java -jar /journal_app/Backend_User-0.0.1-SNAPSHOT.jar && java -jar /journal_app/Backend_User-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
