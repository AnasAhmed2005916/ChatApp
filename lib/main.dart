import 'package:chat_app/core/dependency_injection/service_locator.dart';
import 'package:chat_app/core/routes/app_router.dart';
import 'package:chat_app/core/theme/light_theme.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => ChatApp()),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,

      theme: lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
/**
 * anasahmed12@web-library.net
 * anasanos123
 * 
 * karreemahmed12@web-library.net
 * karreemahmed12
 * 
 */