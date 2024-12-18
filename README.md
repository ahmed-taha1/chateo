# chateo

# **Firebase Chat App with Authentication, Subscriptions, and Notifications**

This project implements a **real-time chat application** using **Firebase Authentication**, **Firestore** for data management, and **Firebase Cloud Messaging (FCM)** for notifications. Users can authenticate via **email/password**, **phone number**, or **Google social login**, subscribe to communities, and participate in chat rooms.

---

## **1. Firebase Realtime Database vs. Firestore**

| **Feature**                   | **Firebase Realtime Database**                    | **Firestore**                                  |
|-------------------------------|--------------------------------------------------|-----------------------------------------------|
| **Data Model**                | JSON tree (NoSQL, hierarchical)                  | Documents and collections (NoSQL, scalable)   |
| **Structure**                 | Single large tree, hard to scale for complex apps| Organized into documents and collections      |
| **Querying**                  | Basic querying, limited indexing                 | Advanced querying, filtering, and indexing    |
| **Real-Time Updates**         | Built-in real-time updates                       | Real-time updates using listeners             |
| **Offline Support**           | Basic offline support                            | Strong offline support with caching           |
| **Scalability**               | Limited scalability for large apps               | Highly scalable for modern applications       |
| **Pricing**                   | Based on bandwidth and data size                 | Based on document reads, writes, and storage  |

---

## **2. Project Overview**

This application features:

- **User Authentication**:
  - Email and Password login
  - Phone Number verification
  - Google Social Media login
- **Community Subscriptions**:
  - Users can subscribe to specific chat communities.
  - Notifications are sent via **Firebase Cloud Messaging** upon subscription.
- **Real-Time Chat Rooms**:
  - Each community contains chat rooms for real-time communication.
  - Messages are stored in **Firestore** for scalability and efficiency.

---

## **3. Key Features**

### **3.1. Authentication**
- **Firebase Authentication** is used to allow users to:
  - Sign up and log in using email and password.
  - Authenticate using phone number OTP verification.
  - Log in via Google social media integration.

### **3.2 Channel Subscriptions**
- Users can **subscribe** or **unsubscribe** from chat channels.
- Notifications are sent when users subscribe to or engage with a channel.

### **3.3 Real-Time Chat Rooms**
- Real-time messaging within channels using **Firestore**.
- Messages are stored efficiently and retrieved instantly.

### **3.4 Event Tracking with Firebase Analytics**
Track user behavior with Firebase Analytics:
- **User Subscription**: Logs when a user subscribes or unsubscribes from a channel.
- **First-Time Login**: Logs when a user logs in for the first time.

### **3.5 Notifications Using Firebase Cloud Messaging (FCM)**
- Send personalized notifications:
  - **Welcome Notification**: Triggered on the first login.
  - **Subscription Notifications**: Triggered when users subscribe to a channel.
- Notifications are configured and tested within the **Firebase Console**.

### **3.6 CI/CD Pipeline with Fastlane and Firebase App Distribution**
- Automated build, test, and deployment pipeline.
- **Fastlane** is used to distribute the app to Firebase App Distribution.
- Seamlessly provides testers access to the latest app versions.
