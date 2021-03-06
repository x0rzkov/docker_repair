FROM fabric8/java-alpine-openjdk8-jdk:latest
ENV JAVA_APP_JAR services-inventoryitem-domain-1.0-SNAPSHOT.jar
ENV AB_OFF true
EXPOSE 8080
ADD target/$JAVA_APP_JAR /deployments/
ADD target/classes/application-jdbc.yml /deployments/
CMD [ "./deployments/run-java.sh", "server", "application-jdbc.yml" ]