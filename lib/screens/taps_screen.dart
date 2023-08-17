import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/favorite_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class TapsScreen extends StatefulWidget {
  static const routeName='tapsScreen';
  @override
  State<TapsScreen> createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  List<Map<String, Object>> _pages = [];

  int selectedPageIndex = 0;

  void selectedPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context,listen: false).getTheme();

    print('get data');
    _pages = [
      {
        'page': CategoryScreen(),
      },
      {
        'page': const FavoriteScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isEng=Provider.of<LanguageProvider>(context,listen: false).isEng;
    final ln=Provider.of<LanguageProvider>(context,listen: true);
    Provider.of<MealProvider>(context,listen: false).getAvailableMeals();
    return Directionality(
      textDirection:isEng?TextDirection.ltr:TextDirection.rtl ,
      child: Scaffold(
        body: _pages[selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectedPage,
          unselectedItemColor: Colors.white,
          selectedItemColor:Theme.of(context).colorScheme.secondary,
          currentIndex: selectedPageIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          items:  [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                  size: 25,
                ),
                label: '${ln.getText("categories")}'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 25,
              ),
              label: '${ln.getText("your_favorites")}'),

          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
