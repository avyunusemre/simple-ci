FROM eclipse-temurin:17-jre
WORKDIR /app

# CI'nın ürettiği jar'ı build context'ten kopyalayacağız
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

