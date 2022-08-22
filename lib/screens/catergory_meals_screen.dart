import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meal';
  final List<Meal> avblMeals;
  const CategoryMealScreen({Key key, @required this.avblMeals})
      : super(key: key);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String title;
  List<Meal> categoryMeal;
  var _initailLoadData = false;

  @override
  void didChangeDependencies() {
    if (!_initailLoadData) {
      final routeArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final id = routeArg['id'];
      title = routeArg['title'];
      categoryMeal = widget.avblMeals.where((element) {
        return element.categories.contains(id);
      }).toList();
      _initailLoadData = true;
    }
  }

  void _removeMeal(String id) {
    setState(() {
      categoryMeal.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: ListView.builder(
          itemCount: categoryMeal.length,
          itemBuilder: (context, index) {
            return MealItem(
              id: categoryMeal[index].id,
              title: categoryMeal[index].title,
              imageUrl: categoryMeal[index].imageUrl,
              duration: categoryMeal[index].duration,
              complexity: categoryMeal[index].complexity,
              affordability: categoryMeal[index].affordability,
              //removeItem: _removeMeal,
            );
          },
        ));
  }
}
