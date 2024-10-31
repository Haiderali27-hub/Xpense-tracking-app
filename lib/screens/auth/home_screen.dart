import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/add-expense'); // Navigate to Add Expense
              },
              child: Text('Add Expense'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/view-expenses'); // Navigate to View Expenses
              },
              child: Text('View Expenses'),
            ),
          ],
        ),
      ),
    );
  }
}
