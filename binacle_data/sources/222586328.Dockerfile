FROM quay.io/enmasse/java-base:11-1

ARG version
ARG maven_version
ARG commit
ENV VERSION=${version} COMMIT=${commit} MAVEN_VERSION=${maven_version}

ADD target/iot-auth-service-${MAVEN_VERSION}.jar /iot-auth-service.jar

ENV JAVA_LAUNCH_PROFILE=openjdk-11
CMD ["/opt/run-java/launch_java.sh", "/iot-auth-service.jar"]
