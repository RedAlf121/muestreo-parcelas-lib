import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/routes.dart';

class MyApp extends StatefulWidget {  
  const MyApp({super.key});
  
  @override
  State<StatefulWidget> createState() => MyAppState();

  
}

class MyAppState extends State<MyApp>{
  bool darkMode = false;
  final TextTheme boldTheme = const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16
    ),
    bodyText2: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
  );
// This widget is the root of your application.
  MyAppState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      title: 'Muestreo Parcelas',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: (darkMode)? ThemeMode.dark : ThemeMode.light,      
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: routesMap(),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.black,
        secondary: Color.fromARGB(255, 60, 144, 36),
        tertiary: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          fontSize: 0
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 0
        ),
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 226, 226, 226),
        size: 30,
        ),
        selectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 255, 255, 255),
        size: 32,
        ),          
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
        foregroundColor: Colors.white
      ),
      brightness: Brightness.dark,
      textTheme: boldTheme,
    );
  }

  ThemeData lightTheme() {

    const greenColor = Color.fromARGB(255, 82, 183, 136);
    ThemeData themeData = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.white,
        secondary: greenColor,          
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: greenColor,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 109, 176, 63),
          fontSize: 24,
        ),
        elevation: 5,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,        
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          fontSize: 0
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 0
        ),
        backgroundColor: greenColor,
        unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 226, 226, 226),
        size: 30,
        ),
        selectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 255, 255, 255),
        size: 32,
        ),
      ),
      iconTheme: const IconThemeData(
        size: 36,         
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: greenColor,
        foregroundColor: Colors.white
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color.fromARGB(255, 82, 183, 136),          
      ),
      textTheme: boldTheme,
    );
    return themeData;
  }

  void switchMode() {
    setState(
      ()=>darkMode = !darkMode
    );
    
  }  
}