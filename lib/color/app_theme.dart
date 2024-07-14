import 'package:flutter/material.dart';

class AppTheme {
  /* theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ), */
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        //primaryColor: Colors.yellow,
        colorScheme: const ColorScheme.dark(
          //seedColor: Color(0xFFFFE301),
          //primary: Colors.yellow,
          primary: Color(0xFF4CAF50),
          secondary: Colors.black,
        ),
        //tema de decoracao dos inputs (text form field)
        inputDecorationTheme: const InputDecorationTheme(

            /*
      //borda activada
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),

      //borda com foco
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color(0xFFFFE301), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),

      //borda de erro
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),

      //borda de erro com foco
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color(0xFFFFE301), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ), */
            ),
      );
}
