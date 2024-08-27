# BLNK Mobile Task

A cross-platform mobile application developed using Flutter and Dart. This application is designed to collect basic user information, scan and process images of a national ID, and store the data securely on Google Drive and Google Sheets.

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Project Architecture](#project-architecture)
4. [State Management](#state-management)
5. [External Integrations](#external-integrations)
6. [Installation and Setup](#installation-and-setup)
7. [How to Use](#how-to-use)
8. [Project Structure](#project-structure)

## Overview

This project demonstrates the implementation of a cross-platform mobile application as per the requirements provided. The app collects user data, scans national ID cards, processes images to extract the ID card from photos, and stores the information in a Google Sheet, with images saved in a Google Drive folder.

## Features

- **User Information Collection**: Gather user details, including first name, last name, detailed address, landline, and mobile number.
- **ID Scanning and Image Processing**:
  - Use the device camera to scan the front and back of a national ID.
  - Extract the ID card from the images using contour detection techniques.
- **Data Storage**:
  - Save user information and image file names to a Google Sheet.
  - Upload ID card images to a specified folder in Google Drive.

## Project Architecture

The application is designed using **Clean Architecture**, which separates the code into distinct layers to improve modularity, scalability, and maintainability. The main layers are **Presentation**, **Business Logic**, **Data**, and **Services**.

### Layers Breakdown

1. **Presentation**: This layer contains the UI components and applications' screens.
   - It includes Flutter widgets responsible for displaying the UI and interacting with the users.
   - Each screen communicates with its corresponding cubit to handle user interactions and state changes.

2. **Business Logic**: This layer contains all the cubits, which manage the state and handle the business logic.
   - **Cubits**: Each cubit is responsible for a specific feature or screen and contains the business logic that processes user input and interacts with the data layer.
   - The Cubit calls the corresponding repository methods to fetch or manipulate data.

3. **Data**: This layer manages the data flow and structure of the application.
   - **Models**: Contains data models like `User` and other entities that represent the structure of the data used in the app.
   - **Repository**: Acts as an intermediary between the Cubit and the API. It adapts the data format to suit the needs of the Cubit and the external APIs.
   - **API**: Responsible for interacting with external services such as Google Drive and Google Sheets to upload data and images, as well as for authentication.

4. **Services**: This layer handles the external services and utilities required by the application.
   - **Edge Detection**: uses image processing to detect the edges of the ID card and crop it from the image.
   - **Email Validator**: Validates the user's email input for correctness.
   - **Authentication**: Manages user authentication with Google services.
   - **Upload to Drive**: Handles the upload of scanned ID images to Google Drive.
   - **Upload to Spreadsheet**: Manages the insertion of user information and image filenames into a Google Sheet.

## State Management

For state management, this project utilizes the **Cubit** from the **Bloc** library. Cubit is a lightweight and simple state management solution that aligns well with the Clean Architecture by keeping the business logic separate from the UI.

## External Integrations

1. **Image Processing**:
   - **Edge Detection Package**: An edge detection package is used for detecting edges of the ID card from the scanned images. This package efficiently extracts the ID card by identifying contours and applying transformations.
   - **Image Picker**: A Flutter plugin for capturing images from the device camera.

2. **Google Sign-In**: Utilized for authenticating the user to access Google services securely. This ensures that user data is uploaded to the correct Google Drive account and Google Sheets.

3. **Google Drive API**: Used to upload and store images of the scanned ID cards. The image URLs are saved in the Google Sheet alongside user details.

4. **Google Sheets API**: Used to store user information in a spreadsheet format. This allows for easy data management and sharing.

## Installation and Setup

To set up and run the project locally, follow these steps:

1. **Clone the repository**:

    ```bash
    git clone https://github.com/m7mda4raf99/blnk_mobile_task.git
    ```

2. **Navigate to the project directory**:

    ```bash
    cd blnk_mobile_task
    ```

3. **Install dependencies**:

    ```bash
    flutter pub get
    ```

4. **Set up Google APIs**:

   - Go to the [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project and enable the Google Sheets API and Google Drive API.
   - Use the following commands to create a Firebase project and set up an Android app automatically:

     ```bash
     npm install -g firebase-tools 
     firebase login
     flutterfire configure
     ```
   
   - After configuring Firebase with your Flutter app, go to the [Firebase Console](https://console.firebase.google.com/). In the Android app settings:
     - Add the SHA-1 and SHA-256 fingerprints for your app.
     - Enable the Google Sign-In method from the Authentication section.
     - Download the `google-services.json` file and replace the existing one in your project.

5. **Run the app**:

    ```bash
    flutter run
    ```

## How to Use

1. **Start the Application**: Launch the app on your device or emulator.
2. **Fill Out the Form**: Enter the required user information.
3. **Scan ID Cards**: Use the camera to scan the front and back of the national ID card.
4. **Submit**: Submit the form to save the information to Google Sheets and upload images to Google Drive.

## Project Structure

The project is organized into the following directories:

`````
/lib
|-- /presentation 
| |-- screens
| | |-- splash_screen.dart
| | |-- registration_screen.dart
| | |-- national_id_screen.dart
| | |-- registration_complete_screen.dart
| |-- widgets
| | |-- app_bar.dart
| | |-- stepper.dart
| | |-- registration_stepper_1.dart
| | |-- registration_stepper_2.dart
| | |-- registration_stepper_3.dart
| | |-- custom_text_field.dart
| | |-- custom_dropdown_field.dart
| | |-- view_user_data.dart
|-- /business_logic 
| |-- /cubit
| | |-- registration_cubit.dart
| | |-- registration_state.dart
|-- /data 
| |-- /models 
| | |-- user.dart 
| |-- /repository 
| | |-- registration_repository.dart 
| |-- /api 
| | |-- registration_api.dart 
|-- /services 
| | |-- email_validation.dart 
| | |-- edge_detector.dart 
| | |-- google_http_client.dart 
| | |-- google_drive.dart 
| | |-- google_spreadsheet.dart
|-- main.dart
`````
