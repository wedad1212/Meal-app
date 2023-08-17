import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/taps_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  static const routeName = 'drawer_screen';

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final isEng=Provider.of<LanguageProvider>(context).isEng;
    final lan=Provider.of<LanguageProvider>(context,listen: false);
    return Directionality(
      textDirection: isEng?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        child: Column(children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment:isEng?Alignment.centerLeft:Alignment.centerRight,
              width: double.infinity,
              height: 150,
              color: accentColor,

              child: Text(
                lan.getText("drawer_name"),


                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 27),
              ),

              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
              () => Navigator.of(context).pushNamed(TapsScreen.routeName),
              Icons.restaurant,
              lan.getText("drawer_item1"),
              context),
          const SizedBox(height: 15),
          buildListTile(
              () => Navigator.of(context).pushNamed(FiltersScreen.routName),
              Icons.settings,
              lan.getText("drawer_item2"),
              context),
          const SizedBox(height: 15),
          buildListTile(
              () => Navigator.of(context).pushNamed(ThemeScreen.routName),
              Icons.color_lens_rounded,
              lan.getText("drawer_item3"),
              context),
          Divider(
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  lan.getText("drawer_switch_item2"),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Switch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEng,
                    onChanged: (selectValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .onChangeLanguage(selectValue);
                    }),
                Text(
                    lan.getText("drawer_switch_item1"),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  ListTile buildListTile(
      GestureTapCallback onTap, IconData icon, String title, BuildContext ctx) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 30, color: Theme.of(ctx).colorScheme.secondary),
      title: Text(title, style: Theme.of(ctx).textTheme.titleLarge),
    );
  }


}
