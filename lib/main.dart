import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/firebase_options.dart';
import 'package:briz_grit/provider/state_controller.dart';
import 'package:briz_grit/screens/home/home_screen.dart';
import 'package:briz_grit/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateController>(
            create: (_) => StateController())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Biz Grit',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.bgColor,
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.appPrimaryGreen),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SpalshScreen()),
    );
  }
}
