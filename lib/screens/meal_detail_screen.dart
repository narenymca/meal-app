import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail-screen';

  final Function toggleFavorite;
  final Function isFavoMeal;

  const MealDetailScreen(
      {Key key, @required this.toggleFavorite, @required this.isFavoMeal})
      : super(key: key);

  Widget buidSectionTitle(String title) {
    return Container(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget buildContainerBox(Widget child) {
    return Container(
      height: 300,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments as String;
    final _meal = DUMMY_MEALS.firstWhere((element) => element.id == _id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buidSectionTitle('Ingredients'),
            buildContainerBox(
              ListView.builder(
                itemCount: _meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(_meal.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
            buidSectionTitle('Steps'),
            buildContainerBox(
              ListView.builder(
                itemCount: _meal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(_meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(_id),
        child: Icon(isFavoMeal(_id) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
