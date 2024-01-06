import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/auth/auth.dart';
import 'package:groceryapp/auth/login_or_register.dart';
import 'package:groceryapp/firebase_options.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/note_database.dart';
import 'package:groceryapp/theme/theme_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'model/transaction.dart';
import 'model/transaction_gen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NoteDataBase.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());

  // Open the Hive box for transactions
  await Hive.openBox<Transaction>('transactions');

  runApp(
    MultiProvider(
      providers: [
        // Note Provider
        ChangeNotifierProvider(create: (context) => NoteDataBase()),

        // Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AuthPage(),
          builder: (context, child) {
            return ChangeNotifierProvider(
              create: (context) => CartModel(),
              child: child!,
            );
          },
          theme: themeProvider.themeData,
        );
      },
    );
  }
}