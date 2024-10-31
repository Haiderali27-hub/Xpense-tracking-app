import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditExpenseScreen extends StatefulWidget {
  final String id; // The ID of the expense to edit
  final String description;
  final String amount;
  final String category;
  final String date;

  EditExpenseScreen({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with existing expense data
    _amountController.text = widget.amount;
    _categoryController.text = widget.category;
    _dateController.text = widget.date;
    _descriptionController.text = widget.description;
  }

  void _editExpense() async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/expenses/edit/${widget.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': _amountController.text,
        'category': _categoryController.text,
        'date': _dateController.text,
        'description': _descriptionController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responseData['message'])));
      Navigator.pop(context); // Go back to the previous screen
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update expense')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editExpense,
              child: Text('Update Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
