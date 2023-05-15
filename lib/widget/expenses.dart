import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //using the class declared in the expense.dart [Expense] list file here instantiating them here
  // and storing the result of this list in _registeredExpense variable.
  final List<Expense> _registeredExpense = [
    Expense(
      title: 'Flutter Course',
      amount: 5000,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 6000,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // Adding a modeal overlay
  // the moment the add button is pressed
  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        //calling this class constructor from new_expense.dart below
        return NewExpense(
            onAddExpense:
                _addExpenses); //connecting the show dialog functon and the new state
      },
    );
  }

  //Adding the new expenses generated from the add buttom modal
  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpense.add(expense); // the expense is been added here.
    });
  }

  //remove expense from the list internally
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense
        .indexOf(expense); //where index of each expense is got
    setState(
      () {
        _registeredExpense.remove(
            expense); // this removes each expense when swiped left or right
      },
    );
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // clears the snackBar after 4 secons
    //utility object that shows a message when expense is deleted
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4), //duration of the message
        content: const Text('Expense deleted'), //shown message
        action: SnackBarAction(
          label: 'Undo', // the message to undo the action of deletion
          onPressed: () {
            //this helps to bring back the expense when undo button is pressed
            setState(() {
              _registeredExpense.insert(expenseIndex,
                  expense); //it must be inside the set stat method.
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    //knowing how much width and height is available is very key before changing the orientation
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses found. Start adding some!'),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpense, //calling the registered expense here
        onRemoveExpense: _removeExpense, //calling the remove pointer here
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense tracker'),
        actions: [
          IconButton(
            onPressed:
                _openAddExpenseOverLay, //calling the function when button is pressed.
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      //here tenary operator is used to switch orientation
      body: width < 600
          ? Column(
              children: [
                //Using the chart dart here
                Chart(expenses: _registeredExpense),
                // const Text('The Chart'),
                // rendering the ListView widget in the expense_list file
                // by calling the ExpenseList widget and its expenses super key below
                Expanded(
                  child:
                      mainContent, //the remove widget or function is called by this variable.
                ),
              ],
            )
          //Else it will display the both in Rows and not column
          : Row(
              children: [
                //Using the chart dart here
                Expanded(
                  child: Chart(expenses: _registeredExpense),
                ),
                // const Text('The Chart'),
                // rendering the ListView widget in the expense_list file
                // by calling the ExpenseList widget and its expenses super key below
                Expanded(
                  child:
                      mainContent, //the remove widget or function is called by this variable.
                ),
              ],
            ),
    );
  }
}
