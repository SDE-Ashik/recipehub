import 'package:flutter/material.dart';
import 'package:recepies_app/pages/home_page.dart';
import 'package:recepies_app/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RecipeHub",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 75, 227, 20),),
        useMaterial3: true,
        appBarTheme:const AppBarTheme(titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,
        fontWeight: FontWeight.bold))
      ),
     
      routes: {
        "/login": (context)=> const LoginPage(),
        "/home" : (context)=>const HomePage(),
      },
      initialRoute: "/login",
    );
  }
}