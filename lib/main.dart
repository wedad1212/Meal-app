import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/OnBoarding_screen.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/screens/taps_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  Widget mainScreen= (preferences.getBool('watched')??false)?TapsScreen():OnBoardingPage();

  runApp(

     MultiProvider(
       providers: [
     ChangeNotifierProvider<MealProvider>(
     create:(ctx)=>MealProvider()),
         ChangeNotifierProvider<ThemeProvider>(
             create:(ctx)=>ThemeProvider()),
         ChangeNotifierProvider<LanguageProvider>(
           create: (ctx)=>LanguageProvider(),
         ),
       ],

        child:MyApp(mainScreen)
      ),
  );
}

class MyApp extends StatelessWidget {
final Widget mainScreen;

  const MyApp( this.mainScreen);
  @override
  Widget build(BuildContext context) {
   final tm=Provider.of<ThemeProvider>(context,listen: true).tm;
   final primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
   final accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      darkTheme: ThemeData(
          primarySwatch: primaryColor,
          canvasColor: Colors.black,
        accentColor: accentColor,
        buttonColor:Colors.white ,
        unselectedWidgetColor: Colors.white70,
        cardColor: const Color.fromRGBO(35, 36, 36, 100),
        textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge:const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.white,
          ) ,
          titleSmall:const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white60,
          ) ,

        ),
      ),
      theme: ThemeData(
        canvasColor: Colors.white,
        splashColor:Colors.black45 ,
        cardColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge:const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.black,
          ) ,
          titleSmall:const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black54,
          ) ,

        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
      ),


      routes: {
        '/': (context) => mainScreen,
        CategoryScreen.routName: (context) => CategoryScreen(),
        MealsScreen.routeName: (context) => MealsScreen(),
        MealScreen.routName: (context) => MealScreen(),
        FiltersScreen.routName: (context) =>
           FiltersScreen(),
        ThemeScreen.routName:(context)=> ThemeScreen(),
        TapsScreen.routeName:(context)=> TapsScreen(),
      },
    );
  }
}


