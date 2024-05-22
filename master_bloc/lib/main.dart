import 'package:flutter/material.dart';
import 'package:master_bloc/features/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue,
            onPrimary: Colors.blue.shade100,
            secondary: Colors.orangeAccent,
            onSecondary: Colors.deepOrange,
            error: Colors.redAccent,
            onError: Colors.red,
            background: Colors.white,
            onBackground: Colors.white,
            surface: Colors.lightBlue.shade400,
            onSurface: const Color.fromARGB(255, 49, 49, 49)),
        appBarTheme: AppBarTheme(
          foregroundColor: Theme.of(context).colorScheme.background,
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
