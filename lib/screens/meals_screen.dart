import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = 'meal_screen';
  late final List availbelMeals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    final ln=Provider.of<LanguageProvider>(context,listen: true);
    final isEng=Provider.of<LanguageProvider>(context,listen: false).isEng;
    final availbelMeals =
        Provider.of<MealProvider>(context, listen: true).availbelMeals;
    final w = MediaQuery.of(context).size.width;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // to decompress Navigator
    final categoryArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final idCategory = categoryArg['id'];


    // to sort the list dummy_meal
    final sortMeal = availbelMeals.where((meal) {
      return meal.categories.contains(idCategory);
    }).toList();

    return Directionality(
      textDirection: isEng?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" ${ln.getText('cat-$idCategory')}"),
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:w<=400?400:500,
            childAspectRatio: isLandScape?w/(w*0.85):w/(w*0.75),
          ),
          itemBuilder: (BuildContext context, int index) {
            return MealItem(
              imageUrl: sortMeal[index].imageUrl,

              duration: sortMeal[index].duration,
              complexity: sortMeal[index].complexity,
              affordability: sortMeal[index].affordability,
              id: sortMeal[index].id,
            );
          },
          itemCount: sortMeal.length,
        ),
      ),
    );
  }
}
