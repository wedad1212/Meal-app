import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  final bool onBoarding;

  FiltersScreen( {this.onBoarding=false});

  static const routName = 'Filters';

  @override


  State<FiltersScreen> createState() => _FiltersScreenState();

}

class _FiltersScreenState extends State<FiltersScreen> {

  @override

  Widget build(BuildContext context) {
    final ln=Provider.of<LanguageProvider>(context);
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Directionality(
      textDirection: ln.isEng?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar:widget.onBoarding?AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,): AppBar(

          title: Text(ln.getText("drawer_item2")),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only( top: 30),
              child:  Text(
                ln.getText( "filters_screen_title"),
                  textAlign:ln.isEng?TextAlign.left:TextAlign.right,

                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwitchListTile(
                    ln.getText("Gluten-free"), ln.getText("Gluten-free-sub"), currentFilters['gluten'],
                    (newValue) {
                  setState(
                    () {
                      currentFilters['gluten'] = newValue;
                     Provider.of<MealProvider>(context,listen: false)
                          .setFilters();
                    },
                  );
                },context),
                buildSwitchListTile(
                    ln.getText("Lactose-free"),  ln.getText("Lactose-free_sub"), currentFilters['lactose'],
                    (newValue) {
                  setState(
                    () {
                      currentFilters['lactose'] = newValue;
                     Provider.of<MealProvider>(context,listen: false)
                          .setFilters();
    },

                  );
                },context),
                buildSwitchListTile(
                    ln.getText("Vegetarian"),   ln.getText("Vegetarian-sub"), currentFilters['vegetarian'],
                    (newValue) {
                  setState(
                    () {
                      currentFilters['vegetarian'] = newValue;
                      Provider.of<MealProvider>(context,listen: false)
                          .setFilters();
                    },
                  );
                },context),
                buildSwitchListTile( ln.getText("Vegan"),  ln.getText("Vegan-sub"), currentFilters['vegan'],
                    (newValue) {
                  setState(
                    () {
                      currentFilters['vegan'] = newValue;
                      Provider.of<MealProvider>(context,listen: false)
                          .setFilters();
                    },
                  );
                },context),
              ],
            )),
            SizedBox(height: widget.onBoarding?100:0,)
          ],
        ),
      ),
    );
  }

  SwitchListTile buildSwitchListTile(
      String title, String description,value, ValueChanged onchange,BuildContext ctx) {
    return SwitchListTile(
      activeTrackColor:Theme.of(context).colorScheme.secondary ,
      activeColor: Theme.of(context).colorScheme.secondary,
      inactiveTrackColor:Theme.of(ctx).splashColor,
      inactiveThumbColor:Theme.of(ctx).splashColor,
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w700, fontSize: 20),
      ),
      subtitle: Text(
        description,
        style: Theme.of(ctx).textTheme.titleSmall!.copyWith(fontSize: 18)
      ),
      value: value,
      onChanged: onchange,
    );
  }
}
