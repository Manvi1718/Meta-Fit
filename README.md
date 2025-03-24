# MetaFit

## Overview
MetaFit is a fitness and nutrition app that provides users with a comprehensive workout and meal planning experience. The app integrates Firebase for authentication and database management, and utilizes multiple APIs to fetch workout exercises, motivational quotes, and meal plans.

## Features
### 🌟 Home (Landing Page)
- Displays **motivational quotes** from the **Motivation Quotes API (RapidAPI)**.
- Dynamic and inspiring messages to keep users motivated.

<img src="https://github.com/user-attachments/assets/70a2588f-165f-4b8e-b628-db0b8430b048" width="200">
<img src="https://github.com/user-attachments/assets/bac9b10c-6fc5-476e-a0ad-fa0534413494" width="200">
<img src="https://github.com/user-attachments/assets/925fc52d-d1e6-401d-93be-2d84b26c8a56" width="200">
<img src="https://github.com/user-attachments/assets/f73bbbee-9c61-40bd-882c-4db27658bd64" width="200">

### 🏋️ Exercises
- Fetches **exercise data** from the **ExerciseDB API (RapidAPI)**.
- Allows users to **search exercises** by name.
- Users can **filter exercises** by:
  - Body Part
  - Equipment
  - Target Muscle

<img src="https://github.com/user-attachments/assets/9b7c11e9-a588-42ad-9694-ff4960afd3fa" width="200">
<img src="https://github.com/user-attachments/assets/cd73f7a1-10d3-4df7-8b04-fc3350b21a2e" width="200">
<img src="https://github.com/user-attachments/assets/62b15015-e6b9-490f-a51c-de3cc1686d88" width="200">
<img src="https://github.com/user-attachments/assets/5614677f-929d-407f-b268-c1945b7dd73a" width="200">


### 🍽️ Nutrition (Meal Planning)
- Users can **create meal plans** using the **Spoonacular API**.
- Meals are stored in **Firebase Firestore**, allowing users to **save and manage meal plans**.
- Supports **multiple users**, ensuring personalized meal planning.

<img src="https://github.com/user-attachments/assets/357ad820-e5c5-45d9-9903-3f579ac329e0" width="200">
<img src="https://github.com/user-attachments/assets/94ec4c16-8167-4025-aa4d-9259b69cb98b" width="200">
<img src="https://github.com/user-attachments/assets/c50da7ff-c418-4a16-8090-c9a1a9b1d559" width="200">
<img src="https://github.com/user-attachments/assets/57d77b1e-6e26-4672-8842-715e2a78ab0b" width="200">


## Tech Stack
- **Flutter** (UI Framework)
- **Firebase Authentication** (User Login/Signup)
- **Cloud Firestore** (Database for storing meal plans)
- **Quotes API (RapidAPI)** (Fetching motivational quotes)
- **ExerciseDB API (RapidAPI)** (Fetching exercises and search functionality)
- **Spoonacular API** (Meal plan generation and recipes)
- **Dart** (Programming language for Flutter)

## Installation
1. Clone the repository:
   ```sh
   git clone [https://github.com/your-username/metafit.git](https://github.com/Manvi1718/Meta-Fit)
   cd metafit
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
   - Set up Firebase for your project.
   - Enable **Authentication** (Email/Google Sign-In).
   - Set up **Cloud Firestore** and add necessary security rules.
4. Run the application:
   ```sh
   flutter run
   ```

## API Keys Setup
You need API keys for:
- **Motivation Quotes API** (RapidAPI)
- **ExerciseDB API** (RapidAPI)
- **Spoonacular API**

Add them in a secure location (`.env` file or Firebase Remote Config) and load them dynamically.

## Future Enhancements
- **User workout tracking**
- **Personalized fitness goals**
- **Push notifications for meal reminders**
- **Light mode customization**

## Contributing
1. Fork the repository.
2. Create a new branch (`feature-branch`).
3. Commit your changes.
4. Push to your forked repo and create a pull request.


