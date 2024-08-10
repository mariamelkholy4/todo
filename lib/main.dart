import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme_data.dart';
import 'package:todo/auth/login/login.dart';
import 'package:todo/home/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:todo/provider/auth_user_provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/auth/register/register.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBsKHjn-EbDyfRT6H4w5lHGsOkTvAn-QMU",
          appId: "com.example.todo",
          messagingSenderId: "3857072765",
          projectId: "todoapp-173ad"
      )
  )
      :
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ListProvider()),
      ChangeNotifierProvider(create: (_) => AuthUserProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
      },
      theme: ThemeDatamain.lightTheme,
      locale: Locale('ar'),
    );
  }
}