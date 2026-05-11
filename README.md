# 📱 Flutter Real-Time Messenger (Firebase + SQLite)

A robust, real-time messaging application built with Flutter. This project demonstrates a hybrid data architecture, using **Firebase** for live synchronization and **SQLite** for high-performance local caching and offline capabilities.

---

## 🚀 Features

### 💻 App Side
* **Real-time Messaging:** Powered by Firebase Firestore for instant message delivery.
* **Authentication:** Secure Login and Signup flow using Firebase Auth.
* **Hybrid Storage:** Messages are fetched from the cloud and persisted locally in SQLite for instant loading.
* **Dynamic UI:** Responsive screens for Chat History, Friends List, and User Profiles.
* **Local Search:** Search through your message history instantly using local SQL queries.

### 📊 Database Side (SQL Mastery)
This project implements advanced database concepts to ensure data integrity and performance:
* **Normalization:** Database design follows **3NF (Third Normal Form)** to reduce redundancy.
* **ER Diagram Logic:** Structured relationships between Users, Conversations, and Messages.
* **Complex Queries:** Implementation of `JOINs` to merge user profiles with message data.
* **Relational Mapping:** Foreign key constraints to maintain referential integrity between local and cloud data.

---

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)
- **State Management:** Provider / Bloc (Update this based on what you used)
- **Real-time DB:** Google Firebase Firestore
- **Local DB:** SQLite (sqflite package)
- **Auth:** Firebase Authentication

---

## 🏗 Database Schema (SQLite)

To improve performance and offline access, the following local schema is used:

### Tables
1. **Users:** `id (PK), username, avatar_url, last_seen`
2. **Messages:** `message_id (PK), sender_id (FK), conversation_id (FK), content, timestamp`

### Example JOIN Query
Used to fetch chat history with user details:
```sql
SELECT m.content, u.username, m.timestamp
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.conversation_id = ?
ORDER BY m.timestamp DESC;
