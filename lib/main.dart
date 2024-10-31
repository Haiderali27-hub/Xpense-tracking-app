import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/home_screen.dart'; // Import your home screen
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart'; // Import the register screen
import 'screens/expenses/add_expense_screen.dart'; // Import Add Expense Screen
import 'screens/expenses/edit_expense_screen.dart'; // Import Edit Expense Screen
import 'screens/expenses/view_expenses_screen.dart'; // Import View Expenses Screen
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
        '/register': (context) => RegisterScreen(),
        '/add-expense': (context) => AddExpenseScreen(),
        '/view-expenses': (context) => ViewExpensesScreen(),
        '/edit-expense': (context) => EditExpenseScreen(
              date: '',
              id: '',
              description: '',
              amount: '',
              category: '',
            ),
      },
    );
  }
}
