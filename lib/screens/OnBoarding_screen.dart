import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/taps_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final ln = Provider.of<LanguageProvider>(context,listen: true);
    final controller = PageController();

    final listPages = [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/main_image.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              width: 300,
              padding: EdgeInsets.all(10),
              color: Colors.black45,
              child: Center(
                  child: Text(
                ln.getText('drawer_name'),
                softWrap: true,
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontSize: 35),
              )),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: 350,
              color: Colors.black45,
              child: Column(
                children: [
                  Text(
                    ln.getText("drawer_switch_title"),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white, fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ln.getText("drawer_switch_item2"),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white60),
                      ),
                      Switch(
                          value: Provider.of<LanguageProvider>(context,
                                  listen: true)
                              .isEng,
                          onChanged: (val) => Provider.of<LanguageProvider>(
                                  context,
                                  listen: false)
                              .onChangeLanguage(val)),
                      Text(
                        ln.getText("drawer_switch_item1"),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white60),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
      ThemeScreen(onBoarding: true),
      FiltersScreen(onBoarding: true),
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: controller,
              itemCount: listPages.length,
              itemBuilder: (BuildContext context, int index) {
                return listPages[index];
              }),

           Align(
                alignment: Alignment(0, 0.85),
                child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TapsScreen()));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('watched', true);
                      },
                      child: Text(
                        ln.getText("start"),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    )),
          ),

          Align(
            alignment: Alignment(0, 0.90),
            child: SmoothPageIndicator(
              controller: controller,
              count: listPages.length,
              effect: WormEffect(
                dotColor: Colors.grey,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotHeight: 14,
                dotWidth: 14,
                type: WormType.thinUnderground,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
