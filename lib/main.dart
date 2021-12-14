import 'package:flutter/material.dart';
import 'package:open_market/screen/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color(0xffffffff),
          scaffoldBackgroundColor: Colors.blueGrey[100],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange[700],
            unselectedItemColor: Colors.grey[600],
          )),
      home: const MainPage(),
    );
  }
}
