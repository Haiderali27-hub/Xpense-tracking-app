import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xpense_tracker_frontend/screens/expenses/add_expense_screen.dart'; // Import your AddExpenseScreen
import 'package:xpense_tracker_frontend/screens/expenses/edit_expense_screen.dart';

class ViewExpensesScreen extends StatefulWidget {
  @override
  _ViewExpensesScreenState createState() => _ViewExpensesScreenState();
}

class _ViewExpensesScreenState extends State<ViewExpensesScreen> {
  List<dynamic> _expenses = [];

  void _fetchExpenses() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/expenses/get'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _expenses = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load expenses')));
    }
  }

  void _deleteExpense(String id) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:3000/expenses/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _expenses.removeWhere(
            (expense) => expense['id'] == id); // Remove from the list
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Expense deleted successfully!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete expense')));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddExpenseScreen()), // Navigate to AddExpenseScreen
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_expenses[index]['description']),
            subtitle: Text('Amount: ${_expenses[index]['amount']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditExpenseScreen(
                          id: _expenses[index]['id'].toString(),
                          description: _expenses[index]['description'],
                          amount: _expenses[index]['amount'].toString(),
                          category: _expenses[index]['category'],
                          date: _expenses[index]['date'],
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteExpense(_expenses[index]['id'].toString());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
