<p align="center">
  <img src="EduPlat.jpeg" alt="EduPlat Logo" width="200"/>
</p>

<h1 align="center">EduPlat</h1>

##  Project Overview

**Edu\_Plat** is an educational mobile platform built using [Flutter](https://flutter.dev/), developed specifically for computer science students and doctors at the Faculty of Science, Ain Shams University. The app provides seamless access to academic resources and services, including:

*  **Online and offline PDF exams** (written and multiple-choice)
*  **Chat functionality** between students and doctors
*  **Study materials** and resources
*  Additional academic tools and services

This document will guide you through setting up and running the app on an Android emulator or physical device using Windows.

---

##  Prerequisites

###  System Requirements

* **OS**: Windows 10/11 or macOS 11+
* **RAM**: Minimum 8 GB
* **Storage**: At least 2 GB free
* **Flutter SDK**: 3.x or later
* **Dart SDK**: Included with Flutter
* **Android Studio** or **Visual Studio Code**
* **Android Emulator** or physical Android device
* **Java Development Kit (JDK)**: Version 11
* **Firebase CLI**: For setting up and managing Firebase services

###  Required Software

| Tool               | Installation Link                                                                            |
| ------------------ | -------------------------------------------------------------------------------------------- |
| Flutter SDK        | [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install) |
| Android Studio     | [https://developer.android.com/studio](https://developer.android.com/studio)                 |
| Visual Studio Code | [https://code.visualstudio.com/](https://code.visualstudio.com/)                             |
| Git                | [https://git-scm.com/downloads](https://git-scm.com/downloads)                               |
| Firebase CLI	      |  [https://firebase.google.com/docs/cli](https://firebase.google.com/docs/cli)

---

##  Setup Instructions

### 1.  Clone the Repository

   ```bash
git clone https://github.com/maryamayman21/edu_plat.git
cd Edu_Plat
```

### 2.  Install Flutter Packages

   ```bash
flutter pub get
```

### 3.  Android Setup

* Open Android Studio
* Go to **More Actions > SDK Manager**

  * Install:

    * Android SDK (API level 33 or later)
    * Android SDK Build-Tools
    * Android Emulator
* Open **Device Manager** to create an Android Virtual Device (AVD)

### 3.  Firebase Setup

  1.Ensure Firebase CLI is installed and added to PATH

  2.Log in to Firebase:
   
  ```bash
   firebase login 
  ```
  3.Configure Firebase for your project:
  ```bash
firebase init
```
  4.Place your `google-services.json` file inside `android/app/`


### 5.  Run the App

Make sure your device/emulator is connected:

   ```bash
flutter devices
flutter run
```

You can also launch it using the "Run" button in Android Studio or VS Code.


##  Configuration

* Add `google-services.json` to the `android/app/` directory.

##  Troubleshooting

| Issue                        | Solution                                                                                                              |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `flutter: command not found` | Add Flutter to your system’s PATH                                                                                     |
| No devices detected          | Start an emulator or connect a device with USB debugging                                                              |
| Gradle or build errors       | Run `flutter clean`, then `flutter pub get`                                                                           |
| Firebase config errors       | Ensure `google-services.json` is correctly placed and formatted                                                       |
| Firebase CLI not found       | Install via `npm install -g firebase-tools` (requires Node.js)                                                        |
| Firebase project issues      |  Run `firebase login`, then `firebase use --add`                                                                      |
|`google-services.json` error  |  Ensure file is placed in `android/app/` and matches the Firebase project configuration                               |


