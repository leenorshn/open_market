import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_market/api/auth_api.dart';
import 'package:open_market/screen/login_page.dart';
import 'package:open_market/screen/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open market',
      theme: ThemeData(
        primaryColor: const Color(0xffffffff),
        scaffoldBackgroundColor: Colors.blueGrey[100],
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange[700],
          unselectedItemColor: Colors.grey[600],
        ),
      ),
      home: StreamBuilder<User?>(
        stream: AuthApi().onAuthChanged(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            return const MainPage();
          }
        },
      ),
    );
  }
}
