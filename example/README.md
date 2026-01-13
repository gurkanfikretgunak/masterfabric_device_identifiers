# Device Identifiers Example

A professional Flutter example app demonstrating the `device_identifiers` plugin using **MasterFabric Core** architecture.

## 🎯 Features Demonstrated

- 📱 **Device ID** - Get unique device identifier (Android/iOS)
- 📟 **IMEI** - Get IMEI number (Android only)
- 🔐 **Permission Handling** - Request and manage phone permissions
- 🏗️ **MasterViewCubit Pattern** - Clean architecture with state management
- 💉 **Dependency Injection** - Injectable + GetIt setup
- 🧭 **GoRouter Navigation** - Declarative routing
- 🎨 **Material Design 3** - Modern UI with custom theme
- 📋 **Copy to Clipboard** - One-tap copy functionality

## 🏗️ Architecture

This example follows the [MasterFabric Core](https://pub.dev/packages/masterfabric_core) pattern:

```
example/
├── lib/
│   ├── app/
│   │   ├── di/
│   │   │   ├── injection.dart           # DI configuration
│   │   │   └── injection.config.dart    # Generated DI
│   │   ├── app.dart                     # MasterApp wrapper
│   │   └── routes.dart                  # GoRouter configuration
│   ├── theme/
│   │   ├── app_theme.dart               # Material Design 3 theme
│   │   └── app_colors.dart              # Color palette
│   ├── views/
│   │   ├── home/
│   │   │   ├── cubit/
│   │   │   │   ├── home_cubit.dart      # Business logic
│   │   │   │   └── home_state.dart      # State definition
│   │   │   └── home_view.dart           # UI (MasterViewCubit)
│   │   ├── device_id/
│   │   │   └── cubit/                   # Device ID state management
│   │   └── imei/
│   │       └── cubit/                   # IMEI state management
│   └── main.dart                        # Entry point
└── assets/
    └── app_config.json                  # App configuration
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.10.4
- Android Studio / Xcode
- iOS Simulator or Android Emulator

### Installation

1. **Navigate to example directory:**
```bash
cd example
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate DI code:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app:**
```bash
flutter run
```

## 📱 What You'll See

### Home Screen
- Overview of available features
- Navigation cards to Device ID and IMEI screens
- Plugin information

### Device ID Screen
- Unique device identifier display
- Platform information (Android/iOS)
- Copy to clipboard functionality
- Refresh button

### IMEI Screen (Android Only)
- IMEI number display
- Permission request flow
- Permission denied handling
- iOS fallback message

## 💡 Key Implementation Details

### MasterViewCubit Pattern

```dart
class HomeView extends MasterViewCubit<HomeCubit, HomeState> {
  HomeView({
    super.key,
    required Function(String) goRoute,
  }) : super(
          currentView: MasterViewCubitTypes.content,
          goRoute: goRoute,
          coreAppBar: (context, viewModel) => AppBar(...),
        );

  @override
  Future<void> initialContent(HomeCubit viewModel, BuildContext context) async {
    await viewModel.loadData();
  }

  @override
  Widget viewContent(BuildContext context, HomeCubit viewModel, HomeState state) {
    return ListView(...);
  }
}
```

### State Management with Cubit

```dart
@injectable
class DeviceIdCubit extends BaseViewModelCubit<DeviceIdState> {
  DeviceIdCubit() : super(const DeviceIdState());

  Future<void> loadDeviceId() async {
    stateChanger(state.copyWith(isLoading: true));
    
    try {
      final deviceId = await DeviceIdentifiers.getDeviceIdentifier();
      stateChanger(state.copyWith(deviceId: deviceId, isLoading: false));
    } catch (e) {
      stateChanger(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
```

### Dependency Injection

```dart
@InjectableInit()
void configureDependencies() => getIt.init();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  
  final router = AppRoutes.createRouter();
  runApp(App(router: router));
}
```

## 🔧 Dependencies

- `masterfabric_core: ^0.0.13` - Core framework with Cubit state management
- `go_router: ^15.1.1` - Declarative routing
- `injectable: ^2.5.0` & `get_it: ^8.0.2` - Dependency injection
- `permission_handler: ^11.2.0` - Runtime permissions
- `lucide_icons_flutter` - Modern icon library
- `equatable: ^2.0.7` - Value equality

## 🧪 Testing Scenarios

1. **Device ID Flow**
   - Launch app → Navigate to Device ID
   - View unique identifier
   - Copy to clipboard
   - Refresh and verify same ID

2. **IMEI Flow (Android)**
   - Navigate to IMEI screen
   - Grant phone permission when requested
   - View IMEI number
   - Try denying permission and see error handling

3. **IMEI Flow (iOS)**
   - Navigate to IMEI screen
   - See "Not available on iOS" message

## 📚 Learn More

- [Device Identifiers Plugin](../README.md)
- [MasterFabric Core Documentation](https://pub.dev/packages/masterfabric_core)
- [Injectable Documentation](https://pub.dev/packages/injectable)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

## 👤 Author

**Gürkan Fikret Günak**
- GitHub: [@gurkanfikretgunak](https://github.com/gurkanfikretgunak)

## 📄 License

This example is part of the `device_identifiers` package. See the [LICENSE](../LICENSE) file for details.

