import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color.fromARGB(255, 11, 14, 206);
// const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {

final bool isDarkmode;
AppTheme({
   
    this.isDarkmode = false,
  });

  ThemeData getTheme() => ThemeData(
    ///* General
    
    colorSchemeSeed: colorSeed,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 20 )
    ),

    ///* Scaffold Background Color
    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    

    ///* Buttons
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: colorSeed,
       shape: CircleBorder(),
       elevation: 2.5,
       foregroundColor: Colors.white,
       
       
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      // color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold),
        centerTitle: false
    )
  );

  AppTheme copyWith({
    bool? isDarkmode
  }) => AppTheme(
    
    isDarkmode: isDarkmode ?? this.isDarkmode,
  );

}