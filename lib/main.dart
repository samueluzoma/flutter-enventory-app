import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:expense_tracker/widget/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
//initializing the dark mode
var kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  //this is used to lock the device
  // into one orientation

  // WidgetsFlutterBinding.ensureInitialized(); //this ensures things works well
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(
    MaterialApp(
      //dark mode color scheme
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkScheme,
        //setting the margin of dark theme the same as the light theme so that it wont be null
        cardTheme: const CardTheme().copyWith(
          color: kDarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkScheme.primaryContainer,
            foregroundColor: kDarkScheme.onPrimaryContainer,
          ),
        ),
      ),
      // light mode theming/styling the entire page and then referenced
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
            ),
      ),
      //themeMode: ThemeMode.system,//this is to make the user select the mode from system

      home: const Expenses(), // returning the scaffold in the expenses widget.
    ),
  );
  //});
}
