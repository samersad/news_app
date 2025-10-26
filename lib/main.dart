import 'package:flutter/material.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(  MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider(),)
  ],
      child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.homeRouteName,
        routes: {
          AppRoutes.homeRouteName:(context)=>HomeScreen(),
        },
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: themeProvider.appTheme,
    );
  }
}
