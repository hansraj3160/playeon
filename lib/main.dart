import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playeon/provider/filter_movies.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';
import 'splashscreen/splashscreen1.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<MoviesGenraProvider>(
        create: (_) => MoviesGenraProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playeon',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: SplashScreen(),
      // home: MainScreen(),
    );
  }
}
