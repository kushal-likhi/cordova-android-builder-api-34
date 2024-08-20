# Cordova Android Builder (API Level 34)

Easily build and automate your Cordova applications using Docker, fully optimized for Android API Level 34. Perfect for local development, CI/CD pipelines, and ensuring consistency across build environments.

## Overview

This repository provides a Docker-based environment for building Cordova Android applications targeting Android API Level 34. It includes all necessary dependencies, making it an ideal solution for both developers and DevOps teams.

## Docker Repository

You can find the pre-built Docker image on Docker Hub:

[https://hub.docker.com/r/kushallikhi/cordova-android-builder-api-34](https://hub.docker.com/r/kushallikhi/cordova-android-builder-api-34)

## Requirements

To use this Docker image, you'll need either:

- **Docker**: For local development.
- **CI/CD Pipeline**: Such as GitHub Actions, Jenkins, etc.

## Installed Dependencies

This Docker image comes with the following pre-installed:

- **Node.js** v20 LTS
- **Cordova** v12.0.0
- **Gradle** v8.7
- **Android Platform Tools**
- **Android Build Tools** 34.0.0
- **Android SDK** API Level 34

## Usage

### Pull the Docker Image

To pull the Docker image from Docker Hub, run:

```bash
docker pull kushallikhi/cordova-android-builder-api-34
```

### Running the Builder Container

#### Check Installed Dependencies

To verify that all dependencies are correctly installed and configured:

```bash
docker run -v <local-app-src>:/opt/src --rm kushallikhi/cordova-android-builder-api-34 cordova requirements
```

#### Build the Android APK

To build your Cordova Android application:

```bash
docker run -v <local-app-src>:/opt/src --rm kushallikhi/cordova-android-builder-api-34 cordova build
```

### Interactive Shell Access

You can also start an interactive shell session within the container for more control:

```bash
docker run -it -v <local-app-src>:/opt/src --rm kushallikhi/cordova-android-builder-api-34 bash
```

From here, you can perform tasks such as adding platforms, checking requirements, and building the application:

```bash
root@cordova:/opt/src# cordova platform add android
root@cordova:/opt/src# cordova requirements
root@cordova:/opt/src# cordova build
```

The generated APK will be located at: `/opt/src/platforms/android/app/build/outputs/apk/`

## Customizing the Docker Image

### Using a Custom Dockerfile

You can extend this Docker image with your own custom configurations by creating a Dockerfile:

```Dockerfile
FROM kushallikhi/cordova-android-builder-api-34

# Add your custom steps here
```

### Installing Additional Android Packages

You may need additional Android packages not included in this image. You can install them interactively or by extending the Dockerfile.

#### Interactive Installation

Attach to the running container:

```bash
docker exec -it <cordova-container-name> bash
```

Install the required packages and accept the licenses:

```bash
root@cordova:/opt/src# sdkmanager "platforms;android-30"
```

To list available packages:

```bash
docker run -it --rm kushallikhi/cordova-android-builder-api-34 sdkmanager --list
```

## Version Tracker

| Version | Description                               | Date       |
|---------|-------------------------------------------|------------|
| 10.9.4  | Initial release with API Level 34 support | 2024-08-20 |

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests. Follow the standard [GitHub Flow](https://guides.github.com/introduction/flow/) when contributing.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have any questions, feel free to open an issue on the [GitHub repository](https://github.com/kushal-likhi/cordova-android-builder-api-34).

---

### Enjoy Building with Cordova and Docker!

This setup provides a consistent and reliable environment for your Cordova Android builds, making your development and deployment processes smoother and more efficient.