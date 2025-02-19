# camera_app


Steps to install.
- Download VSCode. xCode and Android Studio 2019.
- Install Flutter and Dart.
    https://flutter.dev/docs/get-started/install
- Install emulator for android device on Visual Studio (for emulator testing).
- Install ios device emulator on xcode.
NOTE: Camera does not work on ios emulator. Emulator does not have that capability.
- Check Flutter doctor to make sure everything is installed.
- Running it on a physical device (ios)
    https://flutter.dev/docs/get-started/install/macos
    https://www.youtube.com/watch?v=Jn7o4Gy3F7Q&t=197s
- "pod install" in the ios directory.
- If "pod install" does not work delete Podfile and Podfile.lock from ios folder and run "flutter build ios" in project folder 
- Install amplify cli
    "curl -sL https://aws-amplify.github.io/amplify-cli/install | bash && $SHELL"

- Submit to app store
    https://www.youtube.com/watch?v=YPLs3xrDcm0


Steps to Connect to another backend.
- Run "amplify delete" to remove all connections with current backend
- Setup new backend on AWS
- Install API, DataStore, and Auth in that order
- Auth should be installed last

Licenses
- U.I. design, BSD License
    https://github.com/flutter/plugins/blob/master/packages/camera/example/lib/main.dart
- Device Info, BSD License (only used parts).
    https://github.com/flutter/plugins/blob/master/packages/device_info/example/lib/main.dart
