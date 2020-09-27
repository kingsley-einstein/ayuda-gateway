FROM maven:3.6.3-openjdk-11 AS build
COPY src ./src
COPY mvnw* ./
COPY pom.xml ./
RUN mvn clean package -DskipTests

FROM openjdk:11
COPY --from=build target/ayuda-gateway-0.0.1-SNAPSHOT.jar app.jar
EXPOSE $PORT
ENTRYPOINT ["java", "-Dspring.profiles.active=production", "-Xmx256m", "-jar", "app.jar"]
