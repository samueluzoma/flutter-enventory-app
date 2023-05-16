import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  // adding the new expenses
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //manually storing text entered by the user

  // var _enteredText = '';
  // void _savedTitleInput(String input) {
  //   _enteredText = input;
  // }

  // Now handling user input the flutter way
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  //function to trigger the date picker calling it below on the onpress
  void _presentDatePicker() async {
    //adding the async here works with the await keyword
    //initializing the three variables
    //that would hold initialdate, firstdate and lastdate
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    var lastDate = DateTime(now.year + 10, now.month, now.day);
    //the showdatepicker function is a build in
    //functionthat helps display date picker
    final pickedDate = await showDatePicker(
      //the 'await' keyword here makes the picked date to wait
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    // Setting the state for the picked date.
    setState(() {
      _selectedDate = pickedDate;
    });
  } //closing the  date funciton name

  //this helps to dispose the entered text so it does not take space memory.
  @override
  void dispose() {
    _titleController.dispose(); // disposing the title
    _amountController.dispose();
    super.dispose();
  }

  //Showing an error message when a wrong value is entered.
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //calling the showdialog box.
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'), //title of the dialog box
          content: const Text(
              //content of the dialog box goes here.
              'Please make sure a valid title, amount, date and category was entered'),
          // A key to press
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    ctx); // Dismisses the diaglog once the okay key is pressed
              },
              child: const Text('Okay'), //key to be pressed
            ),
          ],
        ),
      );
      return;
    }
    // returning the actual entered values when the above statement is false
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    // closing the modal after finishing selecting your option and submission
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //taking care of the keyboard when in
    //landscape mode and calling using it in the padding bottom.
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height:
          double.infinity, // this makes for taking the entire available space
      child: SingleChildScrollView(
        //this makes it scrollable
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16,
              keyboardSpace + 16), //adding space around the padding widget.
          child: Column(
            children: <Widget>[
              TextField(
                //outputting the manually entered text by the user.
                //onChanged: _savedTitleInput,

                // outputting the textController the flutter way.
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),

              //Wrapp the amount and date into the same row

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      //outputting the manually entered text by the user.
                      //onChanged: _savedTitleInput,

                      // outputting the textController the flutter way.
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .end, //this pushes the children of this row to the end
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //this centers the children of this row vertically within the available space remaining
                      children: [
                        // Calling the _selectedDate in the Text widget below with a tenary operetor
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(
                                  _selectedDate!), //this line format the selected date.
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // given height to the ROW widget down.
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  //Adding a drop down menu for the category part.
                  DropdownButton(
                      style: const TextStyle(
                        //adding style to the drop down manu
                        //backgroundColor: Color.fromARGB(255, 47, 37, 37),
                        //fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      value:
                          _selectedCategory, // initialzin the declared variable up
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                        ;
                      }),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      //using the pop navigation method
                      //provided by flutter to cancel the overlay modal
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //1. print(_enteredText); //this goes with the manual method.

                      // Doing it with controller the flutter war below
                      // print(_titleController);
                      // print(_amountController);
                      _submitExpenseData(); // calling the function if all things is selected properly.
                    },
                    child: const Text('Save Expenses'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
