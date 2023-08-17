import 'package:flutter/material.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;


  const CategoryItem(this.id,  {Key? key}) : super(key: key);

  void selectedCate(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealsScreen.routeName, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    final lan=Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      splashColor: Colors.white,
      onTap: () => selectedCate(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Text(
          lan.getText('cat-$id'),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              ],
            )),
      ),
    );
  }
}
