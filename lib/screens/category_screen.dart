import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/main_drawer.dart';

class CategoryScreen extends StatelessWidget {
  static const routName = 'Category_screen';

  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lan=Provider.of<LanguageProvider>(context,listen: true);
    return
      Scaffold(
        appBar: AppBar(
          title:  Text(lan.getText('drawer_item1')),
          centerTitle: true,
        ),
        body: GridView(
          padding: const EdgeInsets.all(25),
          children: [
            ...Provider.of<MealProvider>(context,listen: true).availbelCategories
                .map<Widget>(
                  (cateData) => CategoryItem(cateData.id, ),
                )
                .toList(),
          ],
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
          ),
        ),
        drawer:  MainDrawer(),
      );
  }
}
