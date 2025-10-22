
# Project Blueprint

## Overview

This document outlines the structure and implementation plan for a Flutter application with a feature-first architecture. The application will include features for authentication, rooms, notes, and analytics.

## Project Structure

```
lib/
├── core/
│   ├── errors/
│   ├── utils/
│   ├── constants/
│   ├── theme/
│   └── router/
│       └── app_router.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/user_model.dart
│   │   │   ├── datasources/auth_remote_data_source.dart
│   │   │   └── repositories/auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/user_entity.dart
│   │   │   ├── repositories/auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── sign_in_usecase.dart
│   │   │       ├── sign_up_usecase.dart
│   │   │       └── sign_out_usecase.dart
│   │   ├── presentation/
│   │   │   ├── cubit/auth_cubit.dart
│   │   │   └── screens/
│   │   │       ├── login_screen.dart
│   │   │       ├── register_screen.dart
│   │   │       └── splash_screen.dart
│   │   └── widgets/
│   │       ├── auth_text_field.dart
│   │       ├── submit_button.dart
│   │       └── auth_header.dart
│   │
│   ├── rooms/
│   │   ├── data/
│   │   │   ├── models/room_model.dart
│   │   │   ├── datasources/room_remote_data_source.dart
│   │   │   └── repositories/room_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/room_entity.dart
│   │   │   ├── repositories/room_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_room_usecase.dart
│   │   │       ├── join_room_usecase.dart
│   │   │       └── get_rooms_usecase.dart
│   │   ├── presentation/
│   │   │   ├── cubit/rooms_cubit.dart
│   │   │   └── screens/
│   │   │       ├── room_list_screen.dart
│   │   │       ├── room_detail_screen.dart
│   │   │       └── invite_screen.dart
│   │   └── widgets/
│   │       ├── room_card.dart
│   │       ├── invite_link_widget.dart
│   │       └── member_avatar.dart
│   │
│   ├── notes/
│   │   ├─ data/
│   │   │   ├── models/note_model.dart
│   │   │   ├── datasources/notes_local_data_source.dart
│   │   │   ├── datasources/notes_remote_data_source.dart
│   │   │   └── repositories/notes_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/note_entity.dart
│   │   │   ├── reposit─ories/notes_repository.dart
│   │   │   └── usecases/
│   │   │       ├── add_note_usecase.dart
│   │   │       ├── get_notes_usecase.dart
│   │   │       ├── delete_note_usecase.dart
│   │   │       └── update_note_usecase.dart
│   │   ├── presentation/
│   │   │   ├── cubit/notes_cubit.dart
│   │   │   └── screens/
│   │   │       ├── notes_list_screen.dart
│   │   │       ├── add_note_screen.dart
│   │   │       └── note_detail_screen.dart
│   │   └── widgets/
│   │       ├── note_card.dart
│   │       ├── photo_preview.dart
│   │       └── note_input_field.dart
│   │
│   └── analytics/
│       ├── presentation/
│       │   ├── cubit/analytics_cubit.dart
│       │   └── screens/analytics_screen.dart
│       └── widgets/
│           ├── category_chart.dart
│           ├── member_spending_chart.dart
│           └── date_filter.dart
│
└── main.dart
```

## Plan

1.  **Create Core Directories:** Create the directories for `core` features.
2.  **Create Feature Directories:** Create the directories for `auth`, `rooms`, `notes`, and `analytics` features.
3.  **Install Dependencies:** Add all necessary dependencies to the `pubspec.yaml` file.
4.  **Create Files:** Populate the directories with the specified Dart files.
5.  **Update `main.dart`:** Update the `main.dart` file to initialize the app.
