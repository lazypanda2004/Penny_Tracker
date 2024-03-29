# pt

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Penny Tracker App
This Expense Tracker App is designed to help users manage their finances effectively by tracking expenses across different categories. It provides a user-friendly interface for adding, deleting, and categorizing transactions, along with comprehensive authentication and account management features. The app utilizes Firebase Firestore for real-time database functionality and incorporates a dynamic analytics page with pie charts for visualizing expense categories.

## Features
Authentication: Secure user authentication system for login and registration.
Account Management: Users can create, update, and delete their accounts.
Real-time Database: Utilizes Firebase Firestore for storing transaction data and user account information.
Transaction Management: Allows users to add and delete transactions, along with categorizing them into different expense categories.
Analytics Page: Provides a visually appealing analytics page with pie charts for a comprehensive overview of expense categories.

## Technologies Used
Flutter
Firebase Firestore: Real-time cloud database for storing transaction data and user information securely.
Firebase Authentication: Secure authentication system for user login and registration.

## Usage
To use the Expense Tracker App, follow these steps:

Clone this repository this repository.
After Cloning, open the project in android studio
Create a new project on Firebase Console
Activate Email SignIn in Firebase auth, and activate Firebase Firestore and Firebase Storage in test mode.
Integrate firebase using the tutorial mentioned above to use your own database (Necessary step else the app wont work)
Run flutter pub get to get the dependencies.

## Acknowledgements
Inspired by other expense tracking apps.
Thanks to Firebase for providing a powerful platform for building real-time applications.
