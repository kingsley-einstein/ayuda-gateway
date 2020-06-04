FROM maven:3-jdk-8-alpine AS build
COPY . ./
RUN mvn clean package -DskipTests
RUN mkdir /app/build && mv ./target/ayuda-gateway-0.0.1-SNAPSHOT.jar /app/build/gateway.jar

FROM openjdk:8-jre-alpine
COPY --from=build /app/build .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "-DPORT=8080", "-Dspring.profiles.active=production", "target/ayuda-gateway-0.0.1-SNAPSHOT.jar"]
