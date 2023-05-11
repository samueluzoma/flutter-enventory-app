import 'package:flutter/material.dart';

import 'package:expense_tracker/widget/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

void main() {
  runApp(
    MaterialApp(
      // For theming/styling the entire page and then referenced
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme, //calling the initialized color scheme
          appBarTheme: const AppBarTheme().copyWith(
            // this is used for theming app bar
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          // theming the card used in this project
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          // theming the elevated button below
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          // theming the various text within our code
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: kColorScheme.onSecondaryContainer,
                ),
              )),
      home: const Expenses(), // returning the scaffold in the expenses widget.
    ),
  );
}
