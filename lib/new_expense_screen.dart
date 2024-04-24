import 'package:flutter/material.dart';

import 'package:expense_tracker/data_models/expense_model.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({required this.onSubmit, super.key});

  final void Function(Expense expense) onSubmit;

  @override
  State<NewExpenseScreen> createState() {
    return _NewExpenseScreenState();
  }
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  var selectedCategory = Category.food;
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime? selectedDate;

  void showDateSelecter() async {
    var today = DateTime.now();
    var firstDate = DateTime(today.year - 1, today.month, today.day);
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: today,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpense() {
    final registeredAmount = double.tryParse(amountController.text);
    final isAmountValid = registeredAmount == null || registeredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        isAmountValid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please fill valid values in title,amount,date and category.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onSubmit(
      Expense(
        title: titleController.text,
        amount: registeredAmount,
        category: selectedCategory,
        date: selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 20),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '₹',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width > 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: selectedCategory,
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()));
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Text(
                        selectedDate == null
                            ? 'No date selected'
                            : dateFormatter.format(selectedDate!),
                      ),
                      IconButton(
                        onPressed: showDateSelecter,
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '₹',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        selectedDate == null
                            ? 'No date selected'
                            : dateFormatter.format(selectedDate!),
                      ),
                      IconButton(
                        onPressed: showDateSelecter,
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                if (width > 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: submitExpense,
                        child: const Text('Save expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: selectedCategory,
                        items: Category.values.map((category) {
                          return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()));
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: submitExpense,
                        child: const Text('Save expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
