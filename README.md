# 🌱 Sproutly

**Online Nursery Shop & Smart Plant Care Application**

---

## 📖 Abstract

**Sproutly** is a complete online nursery shop and smart plant care companion, built using Flutter, Dart, and Firebase. Users can buy a wide variety of plants and gardening products from nurseries. Beyond shopping, Sproutly offers intelligent reminders for watering, fertilizing, and other plant care tasks, customized based on real-time climatic conditions. The app recommends the best plants for each user’s location and climate, and lets users upload images of their plants to detect diseases using AI-powered image analysis. Whether you’re a beginner or an expert gardener, Sproutly helps you keep your plants healthy and thriving.

---

## 💡 Problem Statement

Plant care and gardening are challenging for many due to a lack of timely guidance, unpredictable weather, and difficulty identifying plant health issues. Users struggle to find plants suited for their local environment, often miss essential care activities, and cannot easily diagnose diseases without expert help. Traditional nurseries offer limited after-sales support and rarely provide smart, data-driven care advice.

---

## 📝 Objective

Sproutly solves these issues by combining an online nursery shop with a smart plant care assistant, leveraging the power of Flutter, Dart, and Firebase. It provides timely notifications for plant care based on local weather, recommends suitable plants, and includes an AI-based image diagnosis feature for plant diseases. Sproutly brings together buying, caring, and diagnosing plants into a single, easy-to-use mobile app.

---

## 💻 Hardware Requirements

- Android/iOS smartphone (with minimum 2GB RAM recommended)
- Internet connectivity (Wi-Fi or Mobile Data)
- (Optional) Camera access for plant disease detection

---

## 🖥️ Software Requirements

- Android/iOS (latest version recommended)
- **Flutter** (latest stable version)
- **Dart** (latest stable version)
- **Firebase** (Authentication, Firestore, Storage, Cloud Functions, Messaging)
- Weather API service (for climate data integration)
- Python-based AI/ML API (for plant disease detection, integrated via HTTP)
- Image processing/AI backend (e.g., hosted using Firebase Cloud Functions or Google Cloud Run)

---

## 🏛️ Existing System

- Most plant shopping happens offline or via simple e-commerce platforms without care guidance.
- No personalized reminders or climate-based plant care in existing apps.
- AI-powered disease detection is not available in standard nursery apps.
- Difficult for users to identify or treat plant health problems without experts.

---

## 🚀 Proposed System

- Online plant and gardening shop accessible via a mobile app.
- Personalized reminders for watering, fertilizing, and other care tasks, based on plant type and local weather.
- Recommendations for best plants to buy according to climate and user location.
- AI-powered image upload for plant disease detection with actionable suggestions.
- Comprehensive plant care guides and real-time support, all in one app.

---

## 📦 Modules and Module Description

1. **User Authentication & Profile**
    - Sign up, login, and manage user details securely (Firebase Auth).
2. **Nursery Shop Module**
    - Browse and purchase plants and gardening products.
    - Product search, reviews, and order management (Firestore).
3. **Smart Care Reminder Module**
    - Automatic scheduling and notifications for plant care (watering, fertilizing, etc.), powered by real-time weather data.
    - Push notifications (Firebase Messaging).
4. **Plant Recommendation Module**
    - Suggests plants ideal for the user’s region and climate.
5. **Plant Disease Detection Module**
    - Upload images to detect plant diseases using AI/ML (API integrated with Flutter frontend).
    - Returns disease diagnosis and care suggestions.
6. **Order Tracking Module**
    - Track orders, view history, and manage purchases.
7. **Admin/Vendor Dashboard**
    - Manage inventory, process orders, and view sales analytics (web or in-app panel).
8. **Climate Data Integration Module**
    - Fetch local weather using Weather API to provide context-aware care advice.

---

## 📝 Conclusion

Sproutly leverages modern mobile technology to transform the gardening experience. By integrating a robust online nursery shop with AI-powered, climate-smart plant care features, Sproutly empowers every user—from novices to experts—to confidently buy, care for, and protect their plants. This app creates a smarter, healthier, and more connected community of plant lovers.

---

