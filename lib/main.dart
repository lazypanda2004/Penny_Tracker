import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt/screens/auth.dart';
import 'package:pt/screens/home_tab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pt/screens/splashscreen.dart';
import 'package:pt/screens/tabs.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'penny_tracker',
      theme: ThemeData.dark().copyWith(
        primaryTextTheme: TextTheme(
            titleMedium:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 26, 204, 151),
          brightness: Brightness.dark,
          surface: Color.fromARGB(255, 40, 53, 64),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 6, 7, 7),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return splashscreen();
          }
          if (snapshot.hasData) {
            return TabsScreen();
          }
          return Authscreen();
        },
      ),
    );
  }
}
