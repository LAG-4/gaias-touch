# Gaias Touch

**Gaias Touch** is a Flutter-based mobile application designed to connect users with Non-Governmental Organizations (NGOs) focused on Sustainable Development Goals (SDGs). The app facilitates easy registration, SDG filtering, location-based NGO discovery, and a streamlined request system. Additionally, Gaias Touch integrates in-app donations through Google Pay, a leaderboard feature, chat capabilities, and an AI-powered chatbot to enhance user experience and engagement.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

Gaias Touch is built with the mission to empower users to contribute to global sustainability efforts by connecting them with NGOs that align with their interests. The app provides a user-friendly interface for discovering and interacting with NGOs based on specific SDGs, making it easier for individuals to engage in meaningful activities that support global goals.

## Features

- **User Registration:** Seamless registration process for new users, including the option to log in using social media accounts.
- **SDG Filtering:** Users can filter NGOs based on the SDGs they are passionate about, enabling targeted contributions.
- **Location-Based NGO Discovery:** Discover NGOs near you with location-based services, helping users find relevant organizations in their vicinity.
- **Request System:** A built-in request system allows users to send help requests or volunteer offers directly to NGOs.
- **In-App Donations:** Secure donations through Google Pay, allowing users to support NGOs financially.
- **Leaderboard:** Gamified leaderboard feature to encourage user participation and recognize top contributors.
- **Real-Time Chat:** Chat with NGOs or other users within the app to coordinate activities or seek more information.
- **AI Chatbot:** AI-powered chatbot to assist users in navigating the app, finding NGOs, and answering general queries.

## Technology Stack

### Frontend
- **Flutter**: Cross-platform app development
- **Dart**: Programming language for Flutter

### Backend
- **Firebase**: Real-time database, authentication, and cloud functions
- **Google Maps API**: Location services for discovering NGOs
- **Dialogflow**: AI chatbot for user assistance
- **Google Pay API**: Secure in-app donations

### Additional Tools
- **Postman**: API testing and development
- **GitHub**: Version control and project management

## Architecture

![Gaias Touch Architecture](path_to_architecture_diagram.png)

1. **User Authentication**: Managed through Firebase, supporting email/password, Google, and social logins.
2. **Real-Time Database**: Stores user data, NGO profiles, chat messages, and donation history securely in Firebase.
3. **SDG Filtering**: Integrates with Firebase to dynamically filter NGOs based on selected SDGs.
4. **Location Services**: Google Maps API powers the location-based discovery feature.
5. **AI Chatbot**: Implemented with Dialogflow, integrated into the app for real-time user support.
6. **In-App Donations**: Facilitated through Google Pay, ensuring secure and straightforward transactions.

## Installation

### Prerequisites
- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio or Xcode**: For running the app on an emulator or physical device
- **Firebase Account**: Set up Firebase for authentication, database, and cloud functions
- **Google API Keys**: Obtain API keys for Google Maps and Google Pay

### Steps to Install

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/gaias-touch.git
   cd gaias-touch
   ```
2. Set Up Firebase
   - Create a new Firebase project.
   - Add an Android and/or iOS app to your Firebase project.
   - Download the google-services.json (for Android) or GoogleService-Info.plist (for iOS) and place them in the appropriate directories.
   - 
3. Configure Google APIs
   - Add your Google Maps and Google Pay API keys to the app's configuration file.
4. Install Dependencies
   ```bash
   flutter pub get
   ```
5. Run the App
      ```bash
   flutter run
   ```
## Usage

### Registering and Discovering NGOs

- Complete the registration process and log in to the app.
- Use the SDG filter to discover NGOs that align with your interests.
- View NGO profiles and get involved in their activities.

### Sending a Request

- Navigate to the "Request" tab.
- Fill in the necessary details and send a request to the desired NGO.
- Track the status of your request through the app.

### Making a Donation

- Go to the NGO profile of your choice.
- Select the "Donate" option.
- Follow the prompts to complete the transaction securely via Google Pay.

### Using the Chatbot

- Access the AI chatbot from the main menu.
- Ask questions or request help navigating the app.
- The chatbot will provide real-time assistance and answers.

## Screenshots

### Home Screen

![Home Screen](path_to_home_screen_image.png)

### NGO Discovery

![NGO Discovery](path_to_ngo_discovery_image.png)

### Leaderboard

![Leaderboard](path_to_leaderboard_image.png)
## License

Gaias Touch is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contact

For any inquiries or support, please contact the development team:

- **Project Lead**: Aryan (aryangupta4feb@gmail.com)
- **GitHub**: [LAG-4](https://github.com/LAG-4)
