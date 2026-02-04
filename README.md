<div align="center">
  
  # Taffi
  **Healthcare Appointment System**

  [![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)](https://flutter.dev/)
  [![Backend](https://img.shields.io/badge/Backend-ASP.NET%20Core-512BD4?logo=dotnet)](https://github.com/ENG4CRYO/Taafi.Api)
  [![Architecture](https://img.shields.io/badge/Architecture-Feature--First-orange)](https://github.com/)
  [![State Management](https://img.shields.io/badge/State-Provider-7209b7)](https://pub.dev/packages/provider)
  [![Performance](https://img.shields.io/badge/Performance-60FPS-success)](https://flutter.dev/)
</div>

---

## 🚀 Project Overview

**Taffi** is a robust mobile application engineered to streamline the interaction between patients and healthcare providers. Beyond basic functionality, the project focuses on **scalability**, **performance optimization**, and **clean code principles**.

It features a fully decoupled architecture, ensuring that the UI, business logic, and data layers operate independently for maximum maintainability.

<img width="5760" height="3240" alt="taffi flutter" src="https://github.com/user-attachments/assets/175a4366-58e4-4255-9fb3-74cbf25ee0ae" />

---

## 🏗️ Architecture & Design Patterns

The project adopts a **Feature-First Architecture** combined with the **MVVM (Model-View-ViewModel)** pattern.

### 📂 Feature-First Structure
Instead of grouping files by type (Views, Controllers), the codebase is organized by **Features** (e.g., `Auth`, `Appointment`, `Home`).
* **Scalability:** Each feature is a self-contained module.
* **Maintainability:** Easier to navigate and refactor specific functionalities without affecting the entire codebase.

### 🧩 MVVM & Separation of Concerns
* **View:** Pure UI components responsible only for rendering.
* **ViewModel:** Handles presentation logic and state, decoupled from the UI.
* **Model:** Represents the data structure.
* *Result:* Highly testable code and a clear separation between the interface and logic.

---

## ⚙️ Technical Implementation & Engineering Decisions

### 1. State Management (Provider)
Adopted **Provider** to leverage **Inversion of Control (IoC)**.
* **Why?** To ensure efficient memory usage and separate the application state from the Widget Tree.
* **Mechanism:** Utilizes `ChangeNotifier` for precise change notifications, updating only the necessary widgets to avoid unnecessary rebuilds.

### 2. Networking Layer (Dio)
A custom-built networking layer using **Dio** to handle API communication robustly.
* **Interceptors:** Centralized logic for injecting Authentication Tokens into headers automatically.
* **Error Handling:** A unified `ServerException` handler that parses backend error codes and maps them to user-friendly, localized messages (Arabic support).
* **Resilience:** Configured connection timeouts to maintain UX stability even under poor network conditions.

### 3. Performance Optimization
Achieving **60 FPS** smooth scrolling and efficient resource management:
* **Lazy Loading:** Implemented `SliverGrid` and `CustomScrollView` to render list items only when they appear on screen.
* **Image Caching:** Integrated `cached_network_image` to store doctor profiles and assets locally, significantly reducing data usage and loading times for returning users.

### 4. UI/UX Engineering
* **Responsive Design:** Adaptive layouts that scale seamlessly across different screen sizes and pixel densities.
* **Custom Theming:** A centralized theme configuration ensuring brand consistency (Colors, Typography) throughout the app.

---

## 🔗 Backend Ecosystem

The robust backend infrastructure driving this ecosystem was architected and developed by **Mustafa Aqeel**.

It relies on **ASP.NET Core** to manage complex business logic, ensure data integrity, and handle secure authentication, serving as the reliable core for the Taffi mobile client.

**Backend Repository:** [**Backend API Repository**](https://github.com/ENG4CRYO/Taafi.Api)

---

## 📸 App Screenshots

<div align="center">
 <img width="220" alt="home" src="https://github.com/user-attachments/assets/a33d84dd-1894-4167-9fbd-b46219b66335" />
  &nbsp;&nbsp;
 <img width="220" alt="booking" src="https://github.com/user-attachments/assets/e2ed28fb-4c1e-4d78-8e34-c22dca295c86" />
  &nbsp;&nbsp;
 <img width="220"alt="profile" src="https://github.com/user-attachments/assets/629225a2-300f-4326-86e1-2fdce07a3e69" />
</div>

---

## 🛠️ Tech Stack

* **Framework:** Flutter & Dart
* **State Management:** Provider
* **Networking:** Dio
* **Caching:** Cached Network Image
* **Architecture:** MVVM / Feature-First

---

## 👨‍💻 Developed By

**Huthaifa Mohhamed** - *Flutter Developer*

**Mustafa Aqeel** - *Backend Developer* [**Visit Mustafa's Profile**](https://github.com/ENG4CRYO)
