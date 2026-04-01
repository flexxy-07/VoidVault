import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:void_vault/core/firebase_config.dart';
import 'package:void_vault/core/root_wrapper.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment
  await dotenv.load(fileName: '.env');
  
  await Firebase.initializeApp(
    options: FirebaseConfig.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Void Vault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const RootWrapper(),
    );
  }
}
