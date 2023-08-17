import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';



class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals=Provider.of<MealProvider>(context,listen: true).favoriteMeals;
    final w = MediaQuery.of(context).size.width;
    final ln=Provider.of<LanguageProvider>(context);
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: Text(ln.getText("your_favorites"),),backgroundColor: Theme.of(context).colorScheme.primary,centerTitle: true,),
        body: favoriteMeals.isEmpty?
    Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            ln.getText("favorites_text"),
            style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w700),
          ),
        )
   ):




 GridView.builder(gridDelegate:   SliverGridDelegateWithMaxCrossAxisExtent(
 maxCrossAxisExtent:w<=400?400:500,
   childAspectRatio: isLandScape?w/(w*0.85):w/(w*0.75),
 ),

    itemBuilder: (BuildContext context,int index){
    return MealItem(imageUrl:favoriteMeals[index].imageUrl,

    duration:favoriteMeals[index].duration,
    complexity:favoriteMeals[index].complexity,
    affordability:favoriteMeals[index].affordability,
    id:favoriteMeals[index].id,
    );
    },
    itemCount:favoriteMeals.length,
    ),


    );

  }
}
