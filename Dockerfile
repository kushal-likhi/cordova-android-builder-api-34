# Argument for the version of the image
ARG VERSION

# Argument to specify the version of OpenJDK to use
ARG OPENJDK_VERSION=17

# Set the version, maintainer, and description labels for the Docker image
LABEL maintainer="kushal@codalien.com"
LABEL description="Cordova Android Builder optimized for API Level 34"
LABEL keywords="cordova, android, docker, api-level-34, mobile-app"

# Base image is Eclipse Temurin OpenJDK version specified by the OPENJDK_VERSION argument
FROM eclipse-temurin:${OPENJDK_VERSION}

# Re-reference the OPENJDK_VERSION argument for potential use later in the Dockerfile
ARG OPENJDK_VERSION

# Arguments for the versions of Node.js, Gradle, Cordova, and Android Command-line tools
# These are used to install the specified versions of the tools
ARG NODEJS_VERSION=20
ARG GRADLE_VERSION=8.7
ARG CORDOVA_VERSION=12.0.0
ARG ANDROID_CMDTOOLS_VERSION=11076708

# Set the version label using a RUN command
RUN echo "Setting version label to $VERSION" && \
    LABEL version=$VERSION

# Set the working directory inside the container
WORKDIR /opt/src

# Set environment variables for Java, Android SDK, and Gradle
ENV JAVA_HOME /opt/java/openjdk/
ENV ANDROID_SDK_ROOT /usr/local/android-sdk-linux
ENV ANDROID_HOME $ANDROID_SDK_ROOT
ENV GRADLE_USER_HOME /opt/gradle
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$GRADLE_USER_HOME/bin

# Install Node.js
# Add NodeSource APT repository for Node.js and install Node.js using APT
RUN echo https://deb.nodesource.com/setup_${NODEJS_VERSION}.x
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt -qq install -y nodejs

# Install Cordova globally using npm
RUN npm i -g cordova@${CORDOVA_VERSION}

# Install Gradle
# Download and unzip the specified version of Gradle
RUN apt -qq install -y unzip
RUN curl -so /tmp/gradle-${GRADLE_VERSION}-bin.zip https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -qd /opt /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle

# Install Android SDK Command-line Tools
# Download and unzip the Android SDK command-line tools
RUN curl -so /tmp/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/ && \
    unzip -qd $ANDROID_SDK_ROOT/cmdline-tools/ /tmp/commandlinetools-linux-${ANDROID_CMDTOOLS_VERSION}_latest.zip && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest

# Copy the list of required Android packages from the host to the container
COPY android.packages android.packages

# Install the required Android packages and accept licenses automatically
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | sdkmanager --package_file=android.packages
