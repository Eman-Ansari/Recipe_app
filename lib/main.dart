import 'package:dbproject/HomeScreen.dart';
import 'package:dbproject/loginsignup/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AllRecipesApi/AllRecipes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // home: bottomnavbar(),
        home: Login());
    // home: HomeScreen(),
    // home: AllRecipes());
  }
}
