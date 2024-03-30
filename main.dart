//always build a wireframing before starting bcz it helps in defining the numbber of column and rows that are going to be used
import 'package:assistify/home_page.dart';
import 'package:assistify/pallete.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assistify',
      theme: ThemeData.light(useMaterial3: true).copyWith(//material3 means entire app will be build in material3
        scaffoldBackgroundColor:Pallete.whiteColor,
      appBarTheme: AppBarTheme(//as the appbar where title is written was quite different from the complete screen
        backgroundColor: Pallete.whiteColor,
      )
      ),
      home: const HomePage(),
    );
  }
}