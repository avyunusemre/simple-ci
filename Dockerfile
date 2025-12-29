# ---- Build stage ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Bağımlılık cache'i için önce pom
COPY pom.xml .
RUN mvn -B -ntp -q dependency:go-offline

# Sonra kaynak kod
COPY src ./src

# Jar üret (testleri CI'da koşuyoruz, burada skip)
RUN mvn -B -ntp clean package -DskipTests

# ---- Run stage ----
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
