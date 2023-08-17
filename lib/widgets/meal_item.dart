import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem(
      {Key? key,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.id})
      : super(key: key);

  void selectedMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealScreen.routName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ln = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectedMeal(context),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 20,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Hero(
                      tag: id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          image: NetworkImage(imageUrl),
                          placeholder:AssetImage('assets/images/res.png'),

                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 3,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 220,
                        color: Colors.black45,
                        child: Text(
                          ln.getText('meal-$id'),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ln.getText('min'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ln.getText('$complexity'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ln.getText('$affordability'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
