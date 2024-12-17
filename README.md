# 🎬 Movie & TV Show App

A Flutter application that allows users to explore movies, TV shows, and actors. Users can rate movies, TV shows, and actors, add items to their watchlist, and toggle between light and dark themes. The app is built using Flutter and integrated with **The Movie Database (TMDB) API**.

---

## 📸 **Demo Video**

Watch the video demonstration of the app here:

[![Demo Video](./demo.mp4)](./demo.mp4)  
*(Click to watch the video)*

---

## 🚀 **Features**

1. **Movies & TV Shows**
   - View details about movies and TV shows (title, release date, genres, cast, etc.).
   - Add items to your **Watchlist**.
   - Rate movies and TV shows.

2. **Actor Profiles**
   - View actor details such as their name, age, photo, and popular credits.
   - Rate your favorite actors.

3. **Watchlist**
   - Organize your favorite movies and TV shows in one place.

4. **User Ratings**
   - Keep track of your ratings for movies, TV shows, and actors.

5. **Dark Mode Toggle**
   - Seamlessly switch between light and dark themes from the User Profile.

6. **Search Functionality**
   - Search for movies, TV shows, and actors.

---

## 🛠 **Tech Stack**

- **Flutter**: Framework for building cross-platform applications.
- **TMDB API**: Used to fetch movie, TV show, and actor data.
- **Provider**: State management for UI components.
- **Dio**: HTTP client for API requests.
- **Hive**: Local storage for Watchlist and Ratings.
- **GoRouter**: Navigation management.

---

## 📂 Project Structure

```plaintext
movie_tv_app/
├── 📄 pubspec.yaml               # Project configuration and dependencies
├── 📄 README.md                  # Project documentation
├── 🎥 demo.mp4                   # Demo video of the app
└── 📁 lib/
    ├── 📝 main.dart              # Application entry point
    ├── 📁 core/                  # Core logic and utilities
    │   ├── 📁 api/
    │   │   ├── tmdb_api_service.dart     # Handles TMDB API requests
    │   │   └── tmdb_repository.dart     # Repository for managing API data
    │   ├── 📁 models/
    │   │   ├── movie.dart                # Movie data model
    │   │   ├── tv_show.dart              # TV show data model
    │   │   ├── actor.dart                # Actor data model
    │   │   ├── user_profile.dart         # User profile data model
    │   │   ├── rating.dart               # Rating data model
    │   │   └── watchlist_item.dart       # Watchlist item model
    │   ├── 📁 providers/
    │   │   ├── theme_provider.dart       # Theme state management
    │   │   ├── user_profile_provider.dart# User profile state management
    │   │   ├── watchlist_provider.dart   # Watchlist state management
    │   │   └── rated_provider.dart       # Ratings state management
    │   └── 📁 utils/
    │       ├── constants.dart            # Constants and API keys
    │       └── helpers.dart              # Helper functions
    ├── 📁 features/               # App features
    │   ├── 📁 home/
    │   │   └── pages/
    │   │       └── home_screen.dart      # Home screen
    │   ├── 📁 search/
    │   │   ├── pages/
    │   │   │   └── search_screen.dart    # Search screen
    │   │   └── widgets/
    │   │       ├── search_bar.dart       # Search bar widget
    │   │       └── search_results_list.dart # Search results list widget
    │   ├── 📁 detail/
    │   │   ├── pages/
    │   │   │   ├── movie_detail_screen.dart # Movie details screen
    │   │   │   ├── tv_show_detail_screen.dart # TV show details screen
    │   │   │   └── actor_detail_screen.dart   # Actor details screen
    │   │   └── widgets/
    │   │       ├── cast_list.dart        # Widget for displaying cast list
    │   │       └── info_section.dart     # Widget for displaying details
    │   └── 📁 profile/
    │       ├── pages/
    │       │   ├── user_profile_screen.dart # User profile screen
    │       │   ├── watchlist_screen.dart     # Watchlist screen
    │       │   └── rated_list_screen.dart    # Rated items screen
    │       └── widgets/
    │           └── user_profile_header.dart  # Profile header widget
    └── 📁 router/
        └── app_router.dart             # Application route management
```

---

## 🎥 **How to Run the Project**

1. **Prerequisites**:
   - Flutter SDK installed ([Install Flutter](https://flutter.dev/docs/get-started/install)).
   - A code editor (e.g., VS Code, IntelliJ).
   - TMDB API Key ([Get TMDB API Key](https://www.themoviedb.org)).

2. **Steps**:
   - Clone the repository:
     ```bash
     git clone https://github.com/your-repository-name.git
     cd your-repository-name
     ```
   - Add your TMDB API key in `lib/core/utils/constants.dart`:
     ```dart
     const String TMDB_ACCESS_TOKEN = 'YOUR_API_KEY';
     const String DEFAULT_LANG = 'en-US';
     ```
   - Get the required packages:
     ```bash
     flutter pub get
     ```
   - Run the app on Chrome:
     ```bash
     flutter run -d chrome
     ```
   - To build the release version:
     ```bash
     flutter run -d chrome --release
     ```

---

## 📜 **Known Issues**

- Currently, the app is only optimized for Chrome.
- Flutter web may have some performance issues in debug mode. Use release mode for a smoother experience.

---

## 🤝 **Contributing**

Contributions are welcome! Feel free to open issues or submit pull requests.

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
3. Commit your changes:
   ```bash
   git commit -m "Add new feature"
3. Push the branch:
   ```bash
   git push origin feature/your-feature-name
4. Open a Pull Request.

## 👨‍💻 **Developed By**
Riyad Mazari

## 📄 **License**
This project is licensed under the MIT License. See the LICENSE file for details.

## 🌟 **Acknowledgments**
- Flutter
- TMDB API
- Provider Package
- Dio Package
- Hive Package