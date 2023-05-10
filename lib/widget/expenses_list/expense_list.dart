import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final Function(Expense expense) onRemoveExpense;
  @override
  Widget build(context) {
    // putting the Expense variable declared in expenses.dart ( _registeredExpense )
    // in ListView where it will be automatically scrollable.
    return ListView.builder(
        // by calling the builder it select just one at a time.

        // itemCount: expenses.length,
        // itemBuilder: (ctx, index) =>  ExpenseItem(expenses[index]),

        // this add the dismisses each item when swiped unlike the above code
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(expenses[index]),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            )

        //Text(
        // outputting only the title using Text widget below
        //expenses[index].title,
        );
  }
}
