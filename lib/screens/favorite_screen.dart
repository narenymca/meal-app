import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  List<Meal> favoriteMeal;
  FavoriteScreen({Key key, @required this.favoriteMeal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return const Center(
        child: Text('There is no favorite list of meals selected'),
      )
      ;
    } else {
      return ListView.builder(
          itemCount: favoriteMeal.length,
          itemBuilder: (context, index) {
            return MealItem(
              id: favoriteMeal[index].id,
              title: favoriteMeal[index].title,
              imageUrl: favoriteMeal[index].imageUrl,
              duration: favoriteMeal[index].duration,
              complexity: favoriteMeal[index].complexity,
              affordability: favoriteMeal[index].affordability,
            
            );
          },
        )
      ;
    }
  }
}
