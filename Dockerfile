# Etap 1: Budowanie aplikacji
FROM openjdk:17-oracle as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvnw clean package

# Etap 2: Obraz produkcyjny
FROM gcr.io/distroless/java17-debian12 as runtime
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080

CMD ["/app/app.jar"]
