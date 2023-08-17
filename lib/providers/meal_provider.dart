import 'package:flutter/cupertino.dart';
import 'package:meal_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../2.2 dummy_data.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availbelMeals = DUMMY_MEALS;
  List<Category> availbelCategories = [];
  List<Meal> favoriteMeals = [];
  List<String> listFavoriteMeals = [];

  // to save favorite meals in app
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // to save filters Meals
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    notifyListeners();


    // to save favorite Meals
    listFavoriteMeals = prefs.getStringList('favoriteMeals') ?? [];
    for (var mealId in listFavoriteMeals) {
      final isExist = favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (isExist < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    notifyListeners();
  }


  void setFilters() async {
    availbelMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] == true && !meal.isGlutenFree) return false;
      if (filters['lactose'] == true && !meal.isLactoseFree) return false;
      if (filters['vegan'] == true && !meal.isVegan) return false;
      if (filters['vegetarian'] == true && !meal.isVegetarian) return false;
      return true;
    }).toList();
    getAvailableMeals();

    notifyListeners();
    SharedPreferences filterPrefs = await SharedPreferences.getInstance();
    filterPrefs.setBool('gluten', filters['gluten']!);
    filterPrefs.setBool('lactose', filters['lactose']!);
    filterPrefs.setBool('vegan', filters['vegan']!);
    filterPrefs.setBool('vegetarian', filters['vegetarian']!);
  }
  void getAvailableMeals(){

    List<Meal>fm=[];
    availbelMeals.forEach((avMeals) {
      favoriteMeals.forEach((favMeals) {
        if(avMeals.id==favMeals.id){
          fm.add(favMeals);
        }
      });
    });
    favoriteMeals=fm;


    List<Category> ac = [];

    availbelMeals.forEach((meal) {
      meal.categories.forEach((catMealId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (catMealId == cat.id) {
            if (!ac.any((cat) => cat.id == catMealId)) {
              ac.add(cat);
            }
          }
          availbelCategories = ac;
        });
      });
    });

  }


  void selectedFavorite(String mealId) async {
    final existMeal = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    SharedPreferences favoritePrefs = await SharedPreferences.getInstance();
    if (existMeal >= 0) {
      favoriteMeals.removeAt(existMeal);
      listFavoriteMeals.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      listFavoriteMeals.add(mealId);
    }
    favoritePrefs.setStringList('favoriteMeals', listFavoriteMeals);
    notifyListeners();
  }

  bool isIconSelectedMeal(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }
}
