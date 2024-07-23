# <p align="center">🌟 Holbegram 🌟</p>

![holbegram](https://github.com/user-attachments/assets/a52df175-a3d1-4072-b132-d96f42af8deb)

## 📝 Description

**Holbegram** is an innovative mobile application designed to offer an exceptional user experience on **Android** and **iOS** platforms. By using the powerful Flutter framework and the Dart language, **Holbegram** is distinguished by its performance and fluidity, allowing users to take full advantage of the modern features of a social network.

Designed with an intuitive and responsive interface, **Holbegram** makes it easy to connect users, share captivating visual content, and stay engaged through dynamic interactions. This application is positioned as an essential tool for those looking to maximize their online presence and interact with a constantly evolving community.

## 📚 Resources

- [Dart - Cheatsheet](https://dart.dev/resources/dart-cheatsheet)
- [FlutterFire Overview]()
- [Getting started with Firebase on Flutter]()
- [Get Started with Firebase Authentication on Flutter]()
- [Cloud Storage on Flutter]()
- [Layouts in Flutter]()
- [Introduction to widgets]()
- [Firebase Storage Load and Display Images | Flutter]()
- [Every Flutter Widget Explained](https://www.youtube.com/watch?v=kj_tldMmu4w)

## 📦 Dependencies

- [Firebase Database Plugin for Flutter](https://pub.dev/packages/firebase_database)
- [Firebase Auth for Flutter](https://pub.dev/packages/firebase_auth)
- [Cloud Firestore Plugin for Flutter](https://pub.dev/packages/cloud_firestore)
- [Cloud Storage for Flutter](https://pub.dev/packages/firebase_storage)
- [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
- [Image Picker plugin for Flutter](https://pub.dev/packages/image_picker)
- [BottomNavyBar](https://pub.dev/packages/bottom_navy_bar)
- [provider](https://pub.dev/packages/provider)
- [Uuid](https://pub.dev/packages/uuid)
- [Cached network image](https://pub.dev/packages/flutter_staggered_grid_view)
- [Flutter Pull To Refresh](https://pub.dev/packages/pull_to_refresh#flutter_pulltorefresh)

## 🎬 Video Test

https://github.com/user-attachments/assets/f78c514b-4d67-462d-a003-c8284f421ec6

## 🛠️ Technologies and Tools Used

- `Xcode`: Integrated Development Environment (IDE) used for the development of iOS applications.
- `Flutter`: Framework used for cross-platform development, allowing you to create native applications with a single code base.
- `Dart`: Programming language used with Flutter to write the application code.
- `Firebase`: Backend-as-a-Service platform used for authentication, real-time database, cloud storage and more.
- `Cloud Firestore`: NoSQL database service used to store and synchronize user data in real time.
- `Firebase Authentication`: Used to manage user authentication by email and password.
- `Firebase Storage`: Used to store and serve user-generated files, such as images.

## 📋 Prerequisite

- ![Flutter](https://img.shields.io/badge/flutter-3.22.2-purple)
- ![Dart](https://img.shields.io/badge/dart-3.4.3-pink)
- ![Firebase](https://img.shields.io/badge/firebase-9.0.0-orange)
- ![Xcode](https://img.shields.io/badge/Xcode-15.4-blue) 
- ![Android Studio](https://img.shields.io/badge/Android%20Studio-17.0-green)

## 📊 Data Files

<details>
<summary>pubspec.yaml</summary>
<br>

```yaml
name: holbegram
description: "A new Flutter project."

publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: '>=3.4.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.15.1
  firebase_auth: ^4.20.0
  cloud_firestore: ^4.17.5
  firebase_storage: ^11.7.7
  firebase_database: ^10.5.7
  cupertino_icons: ^1.0.6
  uuid: ^4.4.2
  image_picker: ^1.1.2
  bottom_navy_bar: ^6.1.0
  flutter_staggered_grid_view: ^0.4.0
  badges: ^2.0.2


dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0
  flutter_launcher_icons: ^0.9.2

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/images/user_placeholder.png

  fonts:
      - family: Billabong
        fonts:
          - asset: assets/fonts/Billabong.ttf
      - family: InstagramSans
        fonts:
          - asset: assets/fonts/InstagramSans.ttf

flutter_icons:
  android: false
  ios: true
  remove_alpha_ios: true
  image_path: "assets/icon/icon-appstore.png"
```

</details>

- [Font Family - Billabong](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/assets/fonts/Billabong.ttf)
- [Font Family - InstagramSans](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/assets/fonts/InstagramSans.ttf)
- [Img - Placeholder User](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/assets/images/user_placeholder.png)
- [Img - Logo](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/assets/images/logo.png)
- [Img - Add Image](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/assets/images/add-img.png)

## 🚀 Installation and Configuration

1. **Installation of Flutter:**

    - Download and install Flutter from the official website: [Flutter Installation](https://flutter.dev/docs/get-started/install).
    - Add Flutter to your PATH.

    ```sh
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

1. **Configuration of the development environment:**

    - **`Android Studio:`**
  
      - Download and install [Android Studio](https://developer.android.com/studio).
      - Install the Flutter and Dart plugin in Android Studio.
      - Set up an Android emulator via AVD Manager.
  
    - **`Xcode (for iOS development):`**
  
      - Download and install [Xcode](https://developer.apple.com/xcode/).
      - Open Xcode and install the command line tools: `Xcode > Preferences > Locations > Command Line Tools`.
      - Make sure you have an iOS device or use the built-in iOS simulator.

2. **Creation of a new Flutter project:**

    ```sh
    flutter create holbegram
    cd holbegram
    ```

4. **Add Firebase dependencies:**

    - Use the `pubspec.yaml` file provided and add the necessary dependencies.
    - Then run the following command to install the dependencies:
    
    ```sh
    flutter pub get
    ```

5. **Firebase Configuration:**

    - Create a Firebase project on [Firebase Console](https://console.firebase.google.com/).
    
        - **`Add the Android application:`**
    
            - Save the application using the package name: `com.holbegram.holbegram`.
            - Download the `google-services.json` file and place it in the `android/app` directory.
    
        - **`Add the iOS application:`**
    
            - Save the application using the Bundle ID: `com.holbegram.holbegram`.
            - Download the file `GoogleService-Info.plist` and place it in the `ios/Runner` directory.

6. **Configuration of Gradle files (Android):**

    - Modify `android/build.gradle` to include the Google Services plugin.

    Example of File:

    ```groovy
    buildscript {
      repositories {
        // Check that you have the following line (if not, add it):
        google()  // Google's Maven repository
      }
      dependencies {
        ...
        // Add this line
        classpath 'com.google.gms:google-services:4.3.13'
      }
    }

    allprojects {
      ...
      repositories {
        // Check that you have the following line (if not, add it):
        google()  // Google's Maven repository
        ...
      }
    }
    ```
    
    - Change `android/app/build.gradle` to apply the Google Services plugin:

    Example of File:
   
    ```groovy
    apply plugin: 'com.android.application'
    // Add this line
    apply plugin: 'com.google.gms.google-services'

    dependencies {
      // Import the Firebase BoM
     implementation platform('com.google.firebase:firebase-bom:30.2.0')
    
      // Add the dependencies for any other desired Firebase products
      // https://firebase.google.com/docs/android/setup#available-libraries
    }
    ```

8. **Execution of the project:**

    - To run the application on a device or simulator:
    
    ```sh
    flutter run
    ```

## 💡 Use

To use the Holbegram app on an iPhone for exemple, follow the steps below:

1. **Execution of the application:**

    - Connect your iPhone to your Mac.
    - Select your device in the Xcode toolbar.
    - Click on the Run button to compile and run the application on your iPhone.

2. **Connecting to the application:**

    - Launch the Holbegram application on your iPhone.
    - On the login screen, enter your email address and password or create an account.
    - Click on the ‘Login’ button to connect.

3. **Use of features:**

    - Once connected, you can explore the different features of the application, such as publishing images, adding comments, tracking other users and much more.

## 📸 Screenshots

<img src="https://github.com/user-attachments/assets/36db7945-1761-4b7c-bfb7-8e9f805e7d4f" alt="Login" width="19%"> <img src="https://github.com/user-attachments/assets/2b4606ea-fa3c-41ee-8ec1-570457cb8844" alt="register" width="19%"> <img src="https://github.com/user-attachments/assets/d7a55aca-364b-4470-9383-150363796650" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/2d56bab5-76c4-4d84-9d41-8729b430d441" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/4d4db0d9-19e0-4b4f-b5e9-06e64eb1758a" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/82392a84-7fbb-463e-91f0-1c9a8c5b1df8" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/5a476be3-e228-4e60-b885-05e4011c70e6" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/2e50247a-3044-435f-a854-df261a8b19f1" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/a1a24e13-afb3-464c-a307-a8271fb41ea1" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/1017c39a-18f5-451d-abd0-a760a7d36f71" alt="image profile" width="19%"> <img src="https://github.com/user-attachments/assets/dcf20263-b042-441e-9daf-e3944f57269b" alt="image profile" width="19%">

## ✨ Main Features

1. **`User Authentication`**: Secure authentication system using Firebase, allowing users to log in and register with their email and password.
2. **`Cloud Storage`**: Use of Firebase Storage to store and recover files, including images uploaded by users.
3. **`Real-Time Database`**: Integration of Cloud Firestore for real-time data management, ensuring instant synchronization between devices.
4. **`Integrated Messaging`**: Feature allowing users to communicate directly within the application.
5. **`Social Interactions`**: Possibility for users to like, comment, and share publications, thus increasing engagement and interactivity.
6. **`Publication Management`**: Options for users to modify or delete their publications, offering full control over their content.
7. **`User Tracking`**: Tracking functionality to see the publications of tracked users, with real-time notifications. Possibility to follow and be followed, with dynamic counters of the number of publications, followers and followings.
8. **`Advanced Search`**: Powerful search system to find publications by keyword or username.
9. **`Profile Modification`**: Complete profile page allowing users to update their personal information, such as bio, username, and password.

## 📝 List of Tasks

| Number | Task | Description |
| ------ | ----- | ----------- |
| 0 | [Let's Begin](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/login_screen.dart) | Creation of basic files for login, registration and image download screens. |
| 1 | [Text Widget](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/widgets/text_field.dart) | Construction of a reusable TextField widget. |
| 2 | [Login Page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/login_screen.dart) | Creation of the login page with Firebase authentication. |
| 3 | [Signup Page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/signup_screen.dart) | Creation of the registration page and navigation to the login page. |
| 4 | [Linking the Pages](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/signup_screen.dart) | Link between login and registration pages via navigation. |
| 5 | [Create Our Models](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/models/user.dart) | Creation of user models and publication. |
| 6 | [Auth Methods](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/methods/auth_methods.dart) | Implementation of authentication methods for login and registration. |
| 7 | [Upload User Image](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/upload_image_screen.dart) | Download and management of user images. |
| 8 | [Passing Data Between Pages](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/signup_screen.dart) | Transmission of data between registration and image download pages. |
| 9 | [Providers](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/providers/user_provider.dart) | Creation of a provider for user state management. |
| 10 | [Home Page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/home.dart) | Creation of the home page with lower navigation bar. |
| 11 | [Add a post](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/utils/posts.dart) | Added image publishing functionality. |
| 12 | [Search page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/Pages/search.dart) | Creation of the search page with image display. |
| 13 | [Favorite page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/Pages/favorite.dart) | Implementation of the favorites page with image backup. |
| 14 | [Profile page](https://github.com/MathieuMorel62/holbertonschool-holbegram/blob/main/lib/screens/Pages/profile_screen.dart) | Creation of the profile page with logout options. |

## 📬 Contact
- LinkedIn Profile: [Mathieu Morel](https://www.linkedin.com/in/mathieumorel62/)

