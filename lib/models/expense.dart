// third party id generation package
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; //package for generating id
import 'package:intl/intl.dart'; //package formatting date

// this is initialized in with the uuid as a variable.
const uuid = Uuid();

//initializing the date funcition of intl
final formatter = DateFormat.yMMMd();

// this enum keywoard behaves like a string variable
enum Category { food, travel, leisure, work }

//mapping each category with its own icon of the enum Category
const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  // keys for Expense custom class
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      // Here the above third party id generation package
      //was added as one of the key in this format below
      : id = uuid.v4();
  // variables taken by the Expense custom class.
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //defining a getter for the date formatting
  String get formatedDated {
    return formatter.format(date);
  }
}

//declaring a class to get the total expenses
class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  //constructor function to keep track of total  expense per list.
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    // another type of for loop... provided by dart.
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
