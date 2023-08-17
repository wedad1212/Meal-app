import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../2.2 dummy_data.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';

class MealScreen extends StatelessWidget {
  static const routName = 'maelOneScreen';

  Widget buildText(String txt, BuildContext ctx) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: Theme.of(ctx).textTheme.titleLarge,
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 350,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ln = Provider.of<LanguageProvider>(context, listen: true);
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    List<String> ingredient = ln.getText('ingredients-$mealId');
    List<String> step = ln.getText("steps-$mealId");
    var ingredients = buildContainer(
      context,
      ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext ct, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  ingredient[index],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18),
                )),
          );
        },
        itemCount: selectedMeal.ingredients.length,
      ),
    );

    var steps = buildContainer(
        context,
        ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      "#${index + 1}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  title: Text(
                    step[index],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18),
                  ),
                ),
                const Divider(),
              ],
            );
          },
          itemCount: selectedMeal.steps.length,
        ));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                ln.getText('meal-$mealId'),
                style: TextStyle(fontSize: 15),
              ),
              centerTitle: true,
              background: Hero(
                tag: selectedMeal.id,
                child: InteractiveViewer(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      selectedMeal.imageUrl,
                    ),
                    placeholder: AssetImage('assets/images/res.png'),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (isLandScape)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            buildText(ln.getText("Ingredients"), context),
                            const SizedBox(
                              height: 15,
                            ),
                            ingredients,
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            buildText(ln.getText("Steps"), context),
                            const SizedBox(
                              height: 15,
                            ),
                            steps,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              if (!isLandScape) buildText(ln.getText("Ingredients"), context),
              const SizedBox(
                height: 15,
              ),
              if (!isLandScape) ingredients,
              const SizedBox(
                height: 15,
              ),
              if (!isLandScape) buildText(ln.getText("Steps"), context),
              const SizedBox(
                height: 15,
              ),
              if (!isLandScape) steps,
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Provider.of<MealProvider>(context, listen: true)
                .isIconSelectedMeal(mealId)
            ? Icons.star
            : Icons.star_border),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .selectedFavorite(mealId),
      ),
    );
  }
}
