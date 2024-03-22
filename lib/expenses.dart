import 'package:expense_tracker/Widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widget/newExpense.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpensiveOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter App Expenses"),
        actions: [
          IconButton(
              onPressed: _openAddExpensiveOverLay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text("The cart"),
          Expanded(
              child: ExpensesList(
            expenses: _registeredExpenses,
            onRemovedExpense: _removeExpense,
          ))
        ],
      ),
    );
  }
}
