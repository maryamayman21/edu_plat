
<h1 align="center">EduPlat</h1>

##  Key Features

Edu\_Plat is designed to enhance the academic experience for both doctors and students in the Computer Science program at the Faculty of Science, Ain Shams University. Below is a detailed breakdown of its core functionalities:

---

### 1.  Exams Management (Doctor Dashboard)

Doctors have access to a powerful dashboard that allows them to create and manage various types of exams:

* **Online Exams**:
  Create time-limited online assessments, including support for multiple-choice. Exams are automatically graded where applicable.

* **Offline Exam Announcements**:
  Schedule and announce upcoming in-person exams. Details like date, time, location, and exam type can be specified.

* **PDF Exams (Written & MCQ)**:
  Upload PDF versions of exams for download, including written exams and multiple-choice questions that students can solve offline.

* **Exam Management**:

  * View student submissions and grades
  * Edit or discard previously created exams
  * Monitor student performance across all assessments

---

### 2.  Accessible Materials

Doctors can share a wide range of academic materials to support students' learning:

* **Types of Materials**:

  * Lecture notes
  * Lab manuals
  * Previous exams (with or without solutions)
  * Educational videos

* **Permissions**:

  * **Doctors**: Can upload, edit, and delete materials
  * **Students**: Can view materials  (if synced)

---

### 3. 💬 Chat Functionality

Edu\_Plat includes a robust real-time messaging system to enhance communication:

* **Private Chats**:
  One-on-one messaging between doctors and students

* **Group Chats**:
  Group discussions based on courses, study groups, or projects

* **Community Chats**:
  Public channels where general academic topics or announcements can be discussed by all users in the system

---

### 4. Additional Services

Edu\_Plat provides extra utilities that support student and doctor productivity:

* **GPA Calculator** *(Students)*:
  Helps students track and estimate their Grade Point Average based on course grades and credits.

* **Academic Schedules** *(Both Students & Doctors)*:
  A centralized place to view important dates such as exams, lecture times and Lab times

* **To-Do List** *(Students)*:
  A personal productivity tool where students can add, track, and complete tasks related to their studies.

---

### 5.  Course Registration

A structured course management system that enables:

* **Students**:
  To select and enroll in their current semester courses

* **Doctors**:
  To select and manage the academic courses they are teaching

This ensures that all interactions (e.g., materials, chats, exams) are tied to the correct course and participants.

---

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


### 1.  Android Setup

* Open Android Studio
* Go to **More Actions > SDK Manager**

  * Install:

    * Android SDK (API level 33 or later)
    * Android SDK Build-Tools
    * Android Emulator
* Open **Device Manager** to create an Android Virtual Device (AVD)


### 2.  Clone the Repository

   ```bash
git clone https://github.com/maryamayman21/edu_plat.git
cd Edu_Plat
```

### 3.  Install Flutter Packages

   ```bash
flutter clean
flutter pub get
```

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
  4.Use FlutterFire CLI (Recommended)

You can also automate config setup using:
```bash
dart pub global activate flutterfire_cli
```
at the root of your project run:
```bash
flutterfire configure
```
This generates firebase_options.dart which you can use for initialization.


### 5.  Run the App

Make sure your device/emulator is connected:

   ```bash
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


