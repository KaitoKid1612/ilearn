# iLearn - Ứng dụng học tập cá nhân hóa

Một ứng dụng học tập được xây dựng với Flutter, cho phép người dùng học bất kỳ nội dung nào thông qua bài học, flashcard, trắc nghiệm, và trò chơi. Tích hợp AI để tạo nội dung học tập tự động.

## 🎯 Tính năng chính

- ✅ **Xác thực người dùng**: Đăng nhập, đăng ký, quên mật khẩu
- 📚 **Bài học**: Học các nội dung có cấu trúc
- 🃏 **Flashcard**: Ôn tập bằng thẻ ghi nhớ
- 📝 **Trắc nghiệm**: Kiểm tra kiến thức
- 🎮 **Trò chơi học tập**: Học thông qua trò chơi
- 🤖 **Tạo nội dung với AI**: Sử dụng AI để tạo bài học tự động
- 💾 **Lưu trữ local**: Học offline sau khi tải nội dung

## 🏗️ Kiến trúc dự án

Dự án sử dụng Clean Architecture với cấu trúc:

```
lib/
├── core/
│   ├── constants/       # Hằng số, endpoint, strings
│   ├── config/          # Cấu hình app
│   ├── theme/           # Theme và styling
│   ├── utils/           # Utilities
│   ├── errors/          # Error handling
│   ├── network/         # Network client (Dio)
│   └── routes/          # Routing config (GoRouter)
├── data/
│   ├── models/          # Data models (JSON serializable)
│   ├── datasources/     # Remote & Local datasources
│   │   ├── remote/      # API calls
│   │   └── local/       # Local storage
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Business entities
│   └── usecases/        # Business logic
└── presentation/
    ├── screens/         # UI screens
    ├── widgets/         # Reusable widgets
    └── bloc/            # State management (BLoC)
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.10+
- **State Management**: flutter_bloc
- **Navigation**: go_router
- **Networking**: dio, retrofit
- **Local Storage**: shared_preferences, flutter_secure_storage, hive
- **Code Generation**: freezed, json_serializable
- **Environment**: flutter_dotenv

## 📋 Yêu cầu

- Flutter SDK >= 3.10.4
- Dart SDK >= 3.10.4
- Android Studio / VS Code
- iOS: Xcode 14+ (cho phát triển iOS)

## 🚀 Cài đặt

### 1. Clone repository

```bash
git clone <repository-url>
cd ilearn
```

### 2. Cài đặt dependencies

```bash
flutter pub get
```

### 3. Cấu hình environment variables

Tạo file `.env` từ `.env.example`:

```bash
cp .env.example .env
```

Sau đó chỉnh sửa `.env` với thông tin của bạn:

```env
BASE_URL=https://your-api-url.com
API_KEY=your_api_key_here
OPENAI_API_KEY=your_openai_key_here
```

### 4. Generate code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Chạy app

```bash
flutter run
```

## 📱 Chạy theo platform

### Android

```bash
flutter run -d android
```

### iOS

```bash
flutter run -d ios
```

### Web

```bash
flutter run -d chrome
```

### Windows

```bash
flutter run -d windows
```

## 🔧 Development

### Generate models/code

Khi bạn thay đổi models hoặc thêm annotations mới:

```bash
flutter pub run build_runner watch
```

### Kiểm tra lỗi

```bash
flutter analyze
```

### Format code

```bash
dart format lib/
```

### Run tests

```bash
flutter test
```

## 📂 File quan trọng

- **`lib/main.dart`**: Entry point của app
- **`lib/core/constants/api_endpoints.dart`**: Định nghĩa API endpoints
- **`lib/core/theme/app_theme.dart`**: Theme configuration
- **`.env`**: Environment variables (không commit file này)

## 🎨 Customization

### Đổi màu chủ đạo

Chỉnh sửa trong `lib/core/theme/app_colors.dart`:

```dart
static const Color primary = Color(0xFF6366F1); // Màu bạn muốn
```

### Thêm API endpoint mới

Chỉnh sửa trong `lib/core/constants/api_endpoints.dart`:

```dart
static const String yourEndpoint = '$api/your-path';
```

### Thêm màn hình mới

1. Tạo screen trong `lib/presentation/screens/`
2. Thêm route trong `lib/core/routes/app_router.dart`

## 🔐 Bảo mật

- API keys được lưu trong `.env` (đã thêm vào `.gitignore`)
- Token được lưu an toàn với `flutter_secure_storage`
- Passwords không bao giờ được log hoặc lưu dưới dạng plain text

## 🐛 Troubleshooting

### Lỗi build_runner

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Lỗi dependencies

```bash
flutter pub cache repair
flutter pub get
```

### Lỗi platform specific

```bash
cd android && ./gradlew clean && cd ..
# hoặc
cd ios && pod install && cd ..
```

## 📝 Lộ trình phát triển

- [x] Setup cấu trúc project
- [x] Authentication (Login, Register, Forgot Password)
- [x] Theme & Styling
- [ ] Lessons module
- [ ] Flashcards module
- [ ] Quiz module
- [ ] Games module
- [ ] AI Content Generation
- [ ] Analytics & Progress tracking
- [ ] Offline support
- [ ] Push notifications

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is private and proprietary.

## 👥 Team

- Developer: [Your Name]
- Contact: [Your Email]

## 📞 Support

Nếu bạn gặp vấn đề, vui lòng tạo issue hoặc liên hệ team.
