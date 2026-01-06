# 📚 iLearn - Ứng dụng học Tiếng Nhật thông minh

Ứng dụng học Tiếng Nhật được xây dựng bằng Flutter, hỗ trợ học viên từ N5 đến N1 với các phương pháp học đa dạng: Flashcard, Luyện tập, Kanji, Ngữ pháp và nhiều hơn nữa.

## ✨ Tính năng chính

### 🎯 Học tập

- **Dashboard**: Theo dõi tiến độ học tập, thách thức hàng ngày
- **Roadmap**: Lộ trình học theo giáo trình (Minna no Nihongo, Genki...)
- **Bài học**: Học từ vựng, ngữ pháp, kanji theo từng bài
- **Flashcard**: Ôn tập từ vựng với thẻ ghi nhớ
- **Luyện tập**: Trắc nghiệm đa dạng (Multiple Choice, Fill in Blank, Transform...)
- **Kanji**: Học chữ Hán với video nét viết, ví dụ, gợi nhớ
- **Speaking**: Luyện phát âm với AI

### 👤 Cá nhân hóa

- Theo dõi tiến độ cá nhân
- Thống kê điểm số, thành tích
- Thách thức và phần thưởng
- Quản lý hồ sơ học tập

### 🔐 Xác thực & Bảo mật

- Đăng nhập, đăng ký
- Quên mật khẩu
- Token-based authentication
- Lưu trữ an toàn với Flutter Secure Storage

## 🏗️ Cấu trúc dự án

```
ilearn/
├── lib/
│   ├── core/                    # Core utilities
│   │   ├── constants/          # API endpoints, strings, colors
│   │   ├── config/             # App configuration
│   │   ├── di/                 # Dependency Injection
│   │   ├── errors/             # Error handling
│   │   ├── network/            # Dio client
│   │   ├── routes/             # GoRouter configuration
│   │   ├── theme/              # App theme & styling
│   │   └── utils/              # Helper utilities
│   │
│   ├── data/                    # Data layer
│   │   ├── datasources/        # Remote & Local data sources
│   │   │   ├── remote/         # API calls
│   │   │   └── local/          # Local storage (Hive, SharedPreferences)
│   │   ├── models/             # JSON models
│   │   └── repositories/       # Repository implementations
│   │
│   ├── domain/                  # Business logic
│   │   ├── entities/           # Business entities
│   │   ├── repositories/       # Repository interfaces
│   │   └── usecases/           # Use cases
│   │
│   ├── presentation/            # UI layer
│   │   ├── bloc/               # State management (BLoC)
│   │   ├── screens/            # App screens
│   │   └── widgets/            # Reusable widgets
│   │
│   └── main.dart               # App entry point
│
├── assets/                      # Images, fonts, icons
│   ├── images/
│   ├── fonts/
│   └── icons/
│
├── android/                     # Android configuration
├── ios/                         # iOS configuration
├── web/                         # Web configuration
├── windows/                     # Windows configuration
├── linux/                       # Linux configuration
└── macos/                       # macOS configuration
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart 3.10+
- **State Management**: flutter_bloc
- **Navigation**: go_router
- **Networking**: dio, retrofit
- **Local Storage**: shared_preferences, flutter_secure_storage, hive
- **Dependency Injection**: get_it, injectable
- **Code Generation**: json_serializable, freezed
- **Environment**: flutter_dotenv

## 📋 Yêu cầu hệ thống

- Flutter SDK >= 3.10.4
- Dart SDK >= 3.10.4
- Android Studio hoặc VS Code
- **Android**: Android Studio với Android SDK (API 21+)
- **iOS**: Xcode 14+ (chỉ trên macOS, iOS 12+)
- **Web**: Chrome browser
- **Windows**: Windows 10+
- **Linux**: Ubuntu 20.04+
- **macOS**: macOS 10.14+

## 🚀 Hướng dẫn cài đặt

### 1. Cài đặt Flutter

Nếu chưa cài Flutter, làm theo hướng dẫn tại: https://docs.flutter.dev/get-started/install

Kiểm tra Flutter đã cài đặt:

```bash
flutter --version
flutter doctor
```

### 2. Clone dự án

```bash
git clone https://github.com/KaitoKid1612/ilearn.git
cd ilearn
```

### 3. Cài đặt dependencies

```bash
flutter pub get
```

### 4. Cấu hình Environment Variables

Tạo file `.env` từ template:

**Windows:**

```bash
copy .env.example .env
```

**macOS/Linux:**

```bash
cp .env.example .env
```

Mở file `.env` và cập nhật các thông tin:

```env
BASE_URL=https://your-backend-api.com/api
API_KEY=your_api_key_here
```

> ⚠️ **Lưu ý**: File `.env` chứa thông tin nhạy cảm, không commit lên Git

### 5. Generate code

Dự án sử dụng code generation cho models và dependency injection:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Hoặc chạy ở chế độ watch để tự động generate khi có thay đổi:

```bash
flutter pub run build_runner watch
```

### 6. Chạy ứng dụng

#### Chạy trên Android:

```bash
flutter run -d android
```

#### Chạy trên iOS (chỉ macOS):

```bash
flutter run -d ios
```

#### Chạy trên Web:

```bash
flutter run -d chrome
```

#### Chạy trên Windows:

```bash
flutter run -d windows
```

#### Chạy trên macOS:

```bash
flutter run -d macos
```

#### Chạy trên Linux:

```bash
flutter run -d linux
```

## 🎮 Hướng dẫn sử dụng

### Đăng nhập

1. Mở ứng dụng
2. Nhập email và mật khẩu
3. Hoặc đăng ký tài khoản mới nếu chưa có

### Học tập

1. **Dashboard**:

   - Xem tổng quan tiến độ học tập
   - Theo dõi thách thức hàng ngày
   - Xem thống kê điểm số

2. **Roadmap**:

   - Chọn giáo trình (Minna no Nihongo, Genki, v.v.)
   - Chọn level (N5 → N1)
   - Bắt đầu học từ Unit đầu tiên

3. **Bài học**:

   - **Từ vựng**: Xem nghĩa, ví dụ, nghe phát âm
   - **Kanji**: Xem nét viết, cách đọc On/Kun, từ ghép
   - **Ngữ pháp**: Đọc giải thích, xem ví dụ, cách dùng

4. **Flashcard**:

   - Lật thẻ để học và ghi nhớ từ vựng
   - Đánh dấu đã nhớ/chưa nhớ
   - Ôn tập theo thuật toán Spaced Repetition

5. **Luyện tập**:
   - Làm bài tập trắc nghiệm
   - Nhiều dạng câu hỏi: Multiple Choice, Fill in Blank, Transform
   - Xem kết quả và giải thích chi tiết

## 🔧 Development

### Kiểm tra lỗi code

```bash
flutter analyze
```

### Format code

```bash
dart format lib/
```

### Chạy tests

```bash
flutter test
```

### Build APK (Android)

```bash
flutter build apk --release
```

### Build App Bundle (Android - cho Google Play)

```bash
flutter build appbundle --release
```

### Build IPA (iOS)

```bash
flutter build ipa --release
```

### Build Web

```bash
flutter build web --release
```

### Build Windows

```bash
flutter build windows --release
```

### Build macOS

```bash
flutter build macos --release
```

### Build Linux

```bash
flutter build linux --release
```

## 🐛 Xử lý lỗi thường gặp

### 1. Lỗi build_runner

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Lỗi dependencies

```bash
flutter pub cache repair
flutter pub get
```

### 3. Lỗi Android build

```bash
cd android
gradlew clean
cd ..
flutter clean
flutter pub get
```

### 4. Lỗi iOS build (macOS)

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

### 5. Lỗi "No devices found"

- Kiểm tra thiết bị/emulator đã kết nối:
  ```bash
  flutter devices
  ```
- Khởi động emulator hoặc kết nối thiết bị thật
- Với Web: Đảm bảo Chrome đã cài đặt

### 6. Lỗi .env file

- Đảm bảo file `.env` tồn tại ở root của dự án
- Kiểm tra format đúng: `KEY=value` (không có khoảng trắng xung quanh dấu `=`)
- Không được có dấu ngoặc kép thừa

### 7. Lỗi Gradle (Android)

```bash
cd android
gradlew clean
gradlew build
```

### 8. Lỗi CocoaPods (iOS)

```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
```

## 📦 Build cho Production

### Android APK (cho testing)

```bash
flutter build apk --release --split-per-abi
```

File output: `build/app/outputs/flutter-apk/`

### Android App Bundle (cho Google Play)

```bash
flutter build appbundle --release
```

File output: `build/app/outputs/bundle/release/`

### iOS IPA

```bash
flutter build ipa --release
```

Sau đó upload lên App Store Connect qua Xcode hoặc Transporter

### Web

```bash
flutter build web --release
```

File output: `build/web/`

Deploy lên hosting (Firebase Hosting, Netlify, Vercel, v.v.)

## 🎨 Customization

### Đổi màu chủ đạo

Chỉnh sửa trong `lib/core/theme/app_colors.dart`:

```dart
static const Color primary = Color(0xFF6366F1); // Màu của bạn
static const Color secondary = Color(0xFF8B5CF6);
```

### Thêm API endpoint mới

Chỉnh sửa trong `lib/core/constants/api_endpoints.dart`:

```dart
static const String yourEndpoint = '$api/your-path';
```

### Thêm màn hình mới

1. Tạo screen trong `lib/presentation/screens/your_screen/`
2. Tạo BLoC trong `lib/presentation/bloc/your_bloc/`
3. Thêm route trong `lib/core/routes/app_router.dart`

## 🔐 Bảo mật

- ✅ API keys được lưu trong `.env` (không commit lên Git)
- ✅ Token được lưu an toàn với `flutter_secure_storage`
- ✅ Passwords không bao giờ được log hoặc lưu dưới dạng plain text
- ✅ HTTPS cho mọi API calls
- ✅ Certificate pinning (nếu cần)
- ✅ Code obfuscation khi build production

## 📱 Phiên bản hỗ trợ

- **Android**: 5.0 (API 21) trở lên
- **iOS**: 12.0 trở lên
- **Web**: Chrome, Firefox, Safari, Edge (bản mới nhất)
- **Windows**: Windows 10 trở lên
- **macOS**: macOS 10.14 trở lên
- **Linux**: Ubuntu 20.04 trở lên

## 📝 Lộ trình phát triển

- [x] Setup cấu trúc project
- [x] Authentication (Login, Register, Forgot Password)
- [x] Theme & Styling
- [x] Dashboard với thống kê
- [x] Roadmap học tập
- [x] Lessons module (Vocabulary, Grammar, Kanji)
- [x] Flashcards module
- [x] Quiz module với nhiều dạng câu hỏi
- [ ] Games module
- [ ] Speaking practice với AI
- [ ] Analytics & Progress tracking nâng cao
- [ ] Offline support hoàn chỉnh
- [ ] Push notifications
- [ ] Social features (share, challenge friends)

## 🤝 Đóng góp

Nếu bạn muốn đóng góp cho dự án:

1. Fork repository
2. Tạo branch mới: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Tạo Pull Request

## 📄 License

Dự án này thuộc bản quyền riêng tư.

## 👥 Liên hệ

- **Developer**: Lê Việt
- **Email**: kaitokid101012@gmail.com
- **GitHub**: [@KaitoKid1612](https://github.com/KaitoKid1612)

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:

1. Kiểm tra phần [Xử lý lỗi thường gặp](#-xử-lý-lỗi-thường-gặp)
2. Tạo issue trên GitHub với đầy đủ thông tin:
   - Flutter version: `flutter --version`
   - Mô tả lỗi chi tiết
   - Screenshots (nếu có)
   - Logs (nếu có)
3. Liên hệ qua email

## 🙏 Credits

- Flutter team for the amazing framework
- All open-source libraries used in this project
- Japanese language learning community

---

Made with ❤️ using Flutter
