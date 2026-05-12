<div align="center">

<br/>

```
███╗   ███╗███████╗███████╗███████╗ █████╗  ██████╗ ███████╗
████╗ ████║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝ ██╔════╝
██╔████╔██║█████╗  ███████╗███████╗███████║██║  ███╗█████╗  
██║╚██╔╝██║██╔══╝  ╚════██║╚════██║██╔══██║██║   ██║██╔══╝  
██║ ╚═╝ ██║███████╗███████║███████║██║  ██║╚██████╔╝███████╗
╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
```

### A Real-Time Cross-Platform Messaging Application

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11.5-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Supabase-2.12.4-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com)
[![Firebase](https://img.shields.io/badge/Firebase-Configured-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

<br/>

**Platforms:**
![Android](https://img.shields.io/badge/Android-✓-3DDC84?style=flat-square&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-✓-000000?style=flat-square&logo=apple&logoColor=white)
![Web](https://img.shields.io/badge/Web-✓-4285F4?style=flat-square&logo=googlechrome&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-✓-0078D4?style=flat-square&logo=windows&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-✓-000000?style=flat-square&logo=apple&logoColor=white)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [File Structure](#-file-structure)
- [Tech Stack](#-tech-stack)
- [Database Schema](#-database-schema)
- [Getting Started](#-getting-started)
- [App Screens](#-app-screens)
- [Security & RLS](#-security--row-level-security)
- [Known Issues & Roadmap](#-known-issues--roadmap)
- [Team](#-team)

---

## 🌐 Overview

**MessageApp Flutter** is a full-stack, real-time messaging application built as part of a university software engineering project. It demonstrates end-to-end mobile and web development using **Flutter** for the cross-platform UI and **Supabase** as the backend — covering authentication, a relational database, and live real-time data streaming.

The app allows registered users to send and receive instant messages in private one-on-one chats, with a live-updating contact list and a toggleable dark/light theme.

> **Academic Context:** This project showcases modern app development practices including reactive state management, backend-as-a-service integration, Row Level Security (RLS) policies, real-time data streams, and clean separation of concerns across service, model, and UI layers.

---

## ✨ Features

| Feature | Status | Description |
|---|---|---|
| 🔐 Email Authentication | 🔄 Planned) | Secure sign-up & login via Supabase Auth |
| 💬 Real-Time Messaging | ✅ Live | Messages stream instantly using Supabase Realtime |
| 👥 Contact List | ✅ Live | All registered users listed on the home screen |
| 🌙 Dark / Light Mode | ✅ Live | Persistent theme toggle in Settings |
| 🔒 Row Level Security | 🔄 Planned| Users can only access their own messages |
| 📱 Cross-Platform | ✅🔄halfway| Runs on Android, iOS, Web. does not run on Windows, macOS,Linux |
| 🔔 Push Notifications | 🔄 Planned | Via Firebase Cloud Messaging |
| 👤 User Profiles | 🔄 Planned | Avatars, usernames, bio |
| 📎 Media Messages | 🔄 Planned | Image/file sharing via Supabase Storage |
| 👁️ Read Receipts | 🔄 Planned | Seen indicators on messages |

---

## 🏛 Architecture

The application follows a **layered architecture** pattern separating the UI, business logic, and data layers.

```
┌─────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                       │
│   LoginPage  RegisterPage  HomePage  ChatPage  SettingsPage      │
│           (lib/pages/)   +   (lib/components/)                   │
└────────────────────────────┬────────────────────────────────────┘
                             │ calls
┌────────────────────────────▼────────────────────────────────────┐
│                          SERVICE LAYER                            │
│          AuthService          │         ChatServices              │
│   (authentication/auth_service.dart)  (chat/chat_services.dart)  │
└───────────────┬───────────────┴──────────────┬───────────────────┘
                │                              │
      ┌─────────▼──────────┐       ┌───────────▼────────────┐
      │  Supabase Auth     │       │  Supabase Database     │
      │  (Email/Password)  │       │  (users + messages)    │
      │                    │       │  + Realtime Streams    │
      └────────────────────┘       └────────────────────────┘
```

### State Management

```
ThemeProvider (ChangeNotifier)
        │
        └── Provided at root via Provider package
                │
                └── Consumed by MaterialApp + SettingsPage
                    (dark mode toggle persists for session)
```

### Auth Flow

```
App Start
   │
   └── AuthGate (StreamBuilder on onAuthStateChange)
            │
      ┌─────┴──────┐
      │             │
  Session?      No Session?
      │             │
   HomePage    LoginOrRegister
                    │
              ┌─────┴──────┐
              │             │
          LoginPage    RegisterPage
```

---

## 📁 File Structure

```
message-app/
│
├── 📂 lib/                          ← All Dart application code
│   │
│   ├── 📄 main.dart                 ← Entry point. Supabase init + Provider setup
│   ├── 📄 firebase_options.dart     ← Firebase platform config (FlutterFire CLI)
│   │
│   ├── 📂 Services/
│   │   ├── 📂 authentication/
│   │   │   ├── auth_gate.dart       ← Route guard: checks Supabase session
│   │   │   ├── auth_service.dart    ← signIn / signUp / signOut via Supabase
│   │   │   └── loginOrRegister.dart ← Toggles between Login ↔ Register pages
│   │   │
│   │   └── 📂 chat/
│   │       └── chat_services.dart   ← getUsersStream / sendMessage / getMessages
│   │
│   ├── 📂 model/
│   │   └── message.dart             ← Message data class + toMap()
│   │
│   ├── 📂 pages/
│   │   ├── login_page.dart          ← Login form UI
│   │   ├── register_page.dart       ← Registration form UI
│   │   ├── home_page.dart           ← Contact list (streams all users)
│   │   ├── chat_page.dart           ← Real-time 1-on-1 chat UI
│   │   └── settings_page.dart       ← Dark/Light mode toggle
│   │
│   ├── 📂 components/
│   │   ├── chat_bubble.dart         ← Message bubble (left/right aligned)
│   │   ├── my_button.dart           ← Reusable themed button
│   │   ├── my_drawer.dart           ← Side nav: Home, Settings, Logout
│   │   ├── my_textfield.dart        ← Reusable themed text input
│   │   └── user_tile.dart           ← Contact row widget
│   │
│   └── 📂 themes/
│       ├── light_mode.dart          ← Full light ThemeData definition
│       ├── dark_mode.dart           ← Full dark ThemeData definition
│       └── theme_provider.dart      ← ChangeNotifier for theme state
│
├── 📂 android/                      ← Android platform project
│   └── app/
│       ├── build.gradle.kts
│       └── google-services.json     ← Firebase Android credentials
│
├── 📂 ios/                          ← iOS platform project (Xcode)
│
├── 📄 firebase.json                 ← Firebase project + FlutterFire mapping
├── 📄 pubspec.yaml                  ← Dependencies & project metadata
├── 📄 analysis_options.yaml         ← Dart linting config
└── 📂 .github/workflows/
    └── flutter_web_test.yml         ← GitHub Actions CI for web build
```

---

## 🛠 Tech Stack

| Layer | Technology | Version | Purpose |
|---|---|---|---|
| **UI Framework** | Flutter | 3.x | Cross-platform widget toolkit |
| **Language** | Dart | ^3.11.5 | Strongly-typed, compiled language |
| **Backend / Auth** | Supabase | ^2.12.4 | Auth, PostgreSQL DB, Realtime |
| **State Management** | Provider | ^6.1.5 | Theme state (ChangeNotifier) |
| **Push (planned)** | Firebase Core | ^4.7.0 | FCM push notifications |
| **Database** | PostgreSQL | (via Supabase) | Users + Messages tables |
| **Realtime** | Supabase Realtime | (via Supabase) | Live message streaming |
| **CI/CD** | GitHub Actions | — | Automated web build tests |

### Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:              sdk: flutter
  cupertino_icons:      ^1.0.8    # iOS-style icons
  firebase_core:        ^4.7.0    # Firebase SDK (push notifications)
  firebase_auth:        ^6.4.0    # Firebase Auth (standby)
  cloud_firestore:      ^6.3.0    # Firestore (standby)
  provider:             ^6.1.5    # Theme state management
  supabase_flutter:     ^2.12.4   # Primary backend
```

---

## 🗄 Database Schema

The app uses three tables in Supabase (PostgreSQL):

### `public.users`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | `UUID` | PK, FK → auth.users | Supabase Auth user ID |
| `email` | `TEXT` | NOT NULL | User's email address |
| `contact_key` | `TEXT` | UNIQUE, NOT NULL | Public key for adding friends |

### `public.messages`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | `UUID` | PK, DEFAULT gen_random_uuid() | Unique message ID |
| `sender_id` | `UUID` | FK → users.id | Who sent the message |
| `receiver_id` | `UUID` | FK → users.id | Who receives the message |
| `chat_room_id` | `TEXT` | NOT NULL, Indexed | Sorted UUID pair: `"uid1_uid2"` |
| `message` | `TEXT` | NOT NULL | Message content |
| `timestamp` | `TIMESTAMPTZ` | DEFAULT NOW() | Time sent |

### `public.friends`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `user1` | `TEXT` | FK → users.contact_key | Contact key of first user |
| `user2` | `TEXT` | FK → users.contact_key | Contact key of second user |

### Chat Room ID Generation

Private conversations are identified by deterministically sorting both user UUIDs and joining them:

```dart
List ids = [currentUserID, receiverID];
ids.sort();
String chatRoomID = ids.join('_');
// e.g. "3a1b...ffe_9c2d...a04"
```

This ensures both users always compute the same room ID regardless of who initiates.

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or later)
- [Dart SDK](https://dart.dev/get-dart) (^3.11.5)
- A [Supabase](https://supabase.com) account and project
- Android Studio / Xcode (for mobile targets)
- A modern browser (for web target)

### 1 — Clone the Repository

```bash
git clone https://github.com/your-username/message-app-flutter.git
cd message-app-flutter
```

### 2 — Install Dependencies

```bash
flutter pub get
```

### 3 — Configure Supabase

Run the following SQL in your **Supabase Dashboard → SQL Editor**:

```sql
-- Create users table
CREATE TABLE IF NOT EXISTS public.users (
  id         UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email      TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create messages table
CREATE TABLE IF NOT EXISTS public.messages (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sender_id    UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  receiver_id  UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  chat_room_id TEXT NOT NULL,
  message      TEXT NOT NULL,
  timestamp    TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS users_email_idx
  ON public.users(email);
CREATE INDEX IF NOT EXISTS messages_chat_room_idx
  ON public.messages(chat_room_id, timestamp ASC);

-- Enable RLS
ALTER TABLE public.users    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- RLS Policies: users
CREATE POLICY "Authenticated users can view all users"
  ON public.users FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert their own record"
  ON public.users FOR INSERT TO authenticated WITH CHECK (auth.uid() = id);

-- RLS Policies: messages
CREATE POLICY "Users can view their own messages"
  ON public.messages FOR SELECT TO authenticated
  USING (auth.uid() = sender_id OR auth.uid() = receiver_id);
CREATE POLICY "Users can send messages"
  ON public.messages FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = sender_id);

-- Enable Realtime (safe re-run version)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'users'
  ) THEN ALTER PUBLICATION supabase_realtime ADD TABLE public.users; END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'messages'
  ) THEN ALTER PUBLICATION supabase_realtime ADD TABLE public.messages; END IF;
END $$;
```

### 4 — Add Your Credentials

In `lib/main.dart`, replace the placeholder values with your actual Supabase project credentials (found in **Supabase → Project Settings → API**):

```dart
await Supabase.initialize(
  url: 'https://YOUR_PROJECT_ID.supabase.co',
  anonKey: 'YOUR_ANON_KEY',
);
```

> ⚠️ **Note:** For production, move credentials to a `.env` file using `flutter_dotenv` and never commit secrets to version control.

### 5 — Run the App

```bash
# Android / iOS
flutter run

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

---

## 📱 App Screens

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│              │   │              │   │              │
│  LOGIN PAGE  │   │  HOME PAGE   │   │  CHAT PAGE   │
│              │   │              │   │              │
│  [icon]      │   │ ≡  Home      │   │ ← Alice      │
│              │   │──────────────│   │──────────────│
│  Welcome     │   │ 👤 alice@... │   │  Hello!      │
│  Back!!      │   │ 👤 bob@...   │   │         Hi ▐ │
│              │   │ 👤 carol@... │   │  How are you?│
│  [Email    ] │   │              │   │      Good! ▐ │
│  [Password ] │   │              │   │              │
│  [  Login  ] │   │              │   │ [Type...] ▲  │
│              │   │              │   │              │
└──────────────┘   └──────────────┘   └──────────────┘

┌──────────────┐   ┌──────────────┐   ┌─────────────────┐
│              │   │              │   │                 │
│  REGISTER    │   │  SETTINGS    │   │  Friends Page   │
│              │   │              │   │                 │
│  [icon]      │   │ ← Settings   │   │                 │
│              │   │──────────────│   │  add friend     │
│  Let's start │   │ ┌──────────┐ │   │copy contact_key │
│  an account  │   │ │Dark Mode │ │   │                 │
│              │   │ │       ●  │ │   │                 │
│  [Email    ] │   │ └──────────┘ │   │                 │
│  [Password ] │   │              │   │                 │
│  [Confirm  ] │   │              │   │                 │
│  [Register ] │   │              │   │                 │
│              │   │              │   │                 │
└──────────────┘   └──────────────┘   └─────────────────|
```

---

## 🔒 Security & Row Level Security

Supabase's PostgreSQL Row Level Security (RLS) is enforced at the database level — not just in app code. This means even a direct API request with the public anon key cannot bypass the rules.

| Table | Operation | Policy |
|---|---|---|
| `users` | SELECT | Any authenticated user can view all users |
| `users` | INSERT | Only `auth.uid() = id` (own row only) |
| `users` | UPDATE | Only `auth.uid() = id` (own row only) |
| `messages` | SELECT | Only if `sender_id` or `receiver_id` = `auth.uid()` |
| `messages` | INSERT | Only if `sender_id` = `auth.uid()` |
| `messages` | DELETE | Only if `sender_id` = `auth.uid()` |

---

## 🗺 Known Issues & Roadmap

### 🐛 Known Issues

| # | File | Issue | Severity |
|---|---|---|---|
| 1 | `main.dart` | Supabase credentials hardcoded | 🔴 High |
| 2 | `chat_bubble.dart` | Text always white — invisible on light background | 🟠 Medium |
| 3 | `register_page.dart` | StatelessWidget holds TextEditingControllers | 🟠 Medium |
| 4 | `message.dart` | Uses Firestore Timestamp but app uses Supabase | 🟡 Low |
| 5 | `home_page.dart` | Self-filtering done in UI layer (should be server-side) | 🟡 Low |
| 6 | `my_drawer.dart` | Logout has no confirmation dialog | 🟡 Low |
| 7 | `theme_provider.dart` | Theme resets to light on app restart (not persisted) | 🟡 Low |

### 🔮 Planned Features

```
v1.1  ─── Message timestamps displayed in chat bubbles
      ─── Theme persistence (shared_preferences)
      ─── Logout confirmation dialog
      ─── Search/filter contacts on Home page
      ─── Password reset ("Forgot Password?")

v1.2  ─── User avatars and profile pages
      ─── Typing indicators (Supabase Presence)
      ─── Online/offline status
      ─── Message read receipts

v2.0  ─── Push notifications (Firebase Cloud Messaging)
      ─── Media message support (images via Supabase Storage)
      ─── Group chat rooms
      ─── Message reactions (emoji)
      ─── End-to-end encryption
```

---

## 📐 Project Standards

This project follows these development conventions:

- **Separation of Concerns** — UI pages do not interact with Supabase directly; all DB calls go through the service layer
- **Reactive UI** — All data (auth state, users list, messages) uses Dart `Stream` and `StreamBuilder` — no manual polling
- **Theme Consistency** — All colors are referenced from `Theme.of(context).colorScheme`, never hardcoded
- **Component Reuse** — Shared widgets (`MyButton`, `MyTextField`, `ChatBubble`) are extracted to `lib/components/`
- **Safe Disposal** — All `TextEditingController`, `ScrollController`, and `FocusNode` instances are disposed in `dispose()`

---

## 👥 Team

<div align="center">

| Name | Role | Responsibilities |
|---|---|---|
| — | Lead Developer | Flutter UI, Supabase integration, Auth flow |
| — | Backend Developer | Database schema, RLS policies, Realtime config |
| — | UI/UX Designer | Theme system, component design, screen layouts |

> *Add your team names and student IDs here.*

</div>

---

## 📚 References

- [Flutter Documentation](https://docs.flutter.dev)
- [Supabase Flutter SDK](https://supabase.com/docs/reference/dart/introduction)
- [Supabase Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [Provider Package](https://pub.dev/packages/provider)
- [FlutterFire (Firebase for Flutter)](https://firebase.flutter.dev)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

---

<div align="center">

<br/>

Made with ❤️ using Flutter & Supabase

*University Software Engineering Project — 2026*

<br/>

[![Flutter](https://img.shields.io/badge/Built%20with-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Powered%20by-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com)

</div>
