# 💰 Kitoko Pay – Money Lending Fintech Desktop App

**Kitoko Pay** is a secure, desktop-based fintech application designed to simplify money lending operations for microfinance institutions, SACCOs, and personal finance lenders. Built with **Flutter** and powered by a **Java backend**, Kitoko Pay focuses on seamless user experience, secure data handling, and API-driven operations.

---

## 🧠 Project Summary

- 📦 **Platform**: Desktop (Windows/macOS/Linux)
- 🛠️ **Frontend**: Flutter + Dart
- 🔐 **Security**: Flutter Secure Storage for storing sensitive credentials locally
- 🌐 **Backend**: Java Spring Boot REST API
- 🔌 **Communication**: API-driven via HTTP calls
- ⚙️ **Use Case**: Loan management, repayment tracking, borrower registration

---

## 🎯 Core Features

- ✅ Borrower registration and loan application
- 🔄 Loan disbursement and repayment tracking
- 🧾 Transaction and loan history
- 🔐 Secure login and token storage using `flutter_secure_storage`
- 📡 Real-time communication with backend APIs
- 💻 Cross-platform desktop support

---

## 🧰 Tech Stack

| Layer         | Technology         |
|---------------|--------------------|
| Frontend      | Flutter (Dart)     |
| Backend       | Java (Spring Boot) |
| API Calls     | HTTP (REST)        |
| Secure Storage| Flutter Secure Storage |
| Platform      | Desktop (Flutter)  |

---

## ⚙️ Setup Instructions

### 🔧 Prerequisites

- Flutter SDK (stable version with desktop support enabled)
- JDK 11 or later
- PostgreSQL (optional if used on backend)
- Java backend server running (Spring Boot API)
- Postman (for testing APIs – optional)

---

 API Consumption (Dart Example)
Kitoko Pay uses secure HTTP calls with stored tokens.

### 📦 Flutter App Setup

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();
final token = await storage.read(key: 'auth_token');

final response = await http.get(
  Uri.parse('https://your-api.com/api/loans'),
  headers: {
    'Authorization': 'Bearer $token',
  },
);


```bash
# Clone the repository
git clone https://github.com/Jeffkent01coder/kitokopay.git
cd kitokopay

# Get packages
flutter pub get

# Enable desktop support if not enabled
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop

# Run the app (on your current OS)
flutter run -d windows   # or macos / linux


🚧 Roadmap / Planned Features
🔄 Offline sync (for field agents)

📊 Analytics dashboard

📤 PDF export of loan schedules and reports

📱 Mobile version (future scope)

🤝 Contributing
We welcome contributions, bug reports, and feature suggestions. Please create an issue or submit a PR.

📄 License
MIT License – see the LICENSE file for usage and redistribution rights.

🧑‍💻 Author
Geoffrey Erastus 
GitHub: @Jeffkent01coder
Email: geoffreyerastus956@gmail.com

