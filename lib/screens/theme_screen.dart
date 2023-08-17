import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routName = 'theme';
  final bool onBoarding;
 ThemeScreen( {this.onBoarding=false}) ;

  Widget _buildRadioListTile(
      ThemeMode tm, IconData icon, String title, BuildContext ctx) {
    return RadioListTile(
      value: tm,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .changeThemeMode(newThemeVal),
      secondary: Icon(
        icon,
        color: Theme.of(ctx).colorScheme.secondary,
      ),
      title: Text(title),
    );
  }

  Widget _buildListTile(String txt, BuildContext ctx) {
    final ln=Provider.of<LanguageProvider>(ctx);
    final primaryColor =
        Provider.of<ThemeProvider>(ctx, listen: true).primaryColor;
    final accentColor =
        Provider.of<ThemeProvider>(ctx, listen: true).accentColor;
    Color selectedColor = txt == ln.getText("primary") ? primaryColor : accentColor;
    return ListTile(
        title: Text(
          txt,
          style: Theme.of(ctx).textTheme.titleLarge,
        ),
        trailing: CircleAvatar(backgroundColor: selectedColor),
        onTap: () => showDialog(
            context: ctx,
            builder: (BuildContext ctx) => AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: Column(children: [
                    ColorPicker(
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                      colorPickerWidth: 250,
                      pickerAreaHeightPercent: 0.7,
                      pickerColor: selectedColor,
                      onColorChanged: (Color newValue) {
                        Provider.of<ThemeProvider>(ctx, listen: false)
                            .setColors(
                          txt == ln.getText("primary") ? 1 : 2,
                          newValue,
                        );
                        selectedColor=newValue;
                      },
                    ),


                  ]),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final ln = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar:onBoarding?AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,): AppBar(
        title: Text(ln.getText("drawer_item3")),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              ln.getText("theme_screen_title"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      ln.getText("theme_mode_title"),
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                _buildRadioListTile(ThemeMode.light, Icons.light_mode,
                    ln.getText("light_theme"), context),
                const SizedBox(
                  height: 15,
                ),
                _buildRadioListTile(ThemeMode.dark, Icons.dark_mode,
                    ln.getText("dark_theme"), context),
                const SizedBox(
                  height: 15,
                ),
                _buildListTile(ln.getText("primary"), context),
                const SizedBox(
                  height: 10,
                ),
                _buildListTile(ln.getText("accent"), context),
              ],
            ),
          ),
          SizedBox(height: onBoarding?100:0,)
        ],
      ),
      drawer: onBoarding?null: MainDrawer(),
    );
  }
}
