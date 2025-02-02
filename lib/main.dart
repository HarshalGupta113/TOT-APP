import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tot_app/providers/dog_provider.dart';
import 'package:tot_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DogProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'TOT APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
