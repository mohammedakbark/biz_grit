import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/screens/home/home_screen.dart';
import 'package:briz_grit/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biz Grit',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.appPrimaryGreen),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SpalshScreen());
  }
}
