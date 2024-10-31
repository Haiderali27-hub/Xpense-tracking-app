import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart'; // Import your home screen
import 'screens/login_screen.dart';
import 'screens/register_screen.dart'; // Import the register screen
import 'services/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..loadToken(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return authProvider.token != null
                    ? HomeScreen()
                    : LoginScreen();
              },
            ),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(), // Register route
      },
    );
  }
}
