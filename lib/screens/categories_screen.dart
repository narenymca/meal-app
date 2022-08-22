import 'package:flutter/material.dart';
import 'package:meal/widgets/categories_item.dart';
import 'package:meal/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'DeliMeals',
      //     style: Theme.of(context).textTheme.titleLarge,
      //   ),
      // ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((e) {
          return CatergoryItem(
            title: e.title,
            color: e.color,
            id: e.id,
          );
        }).toList(),
      ),
    );
  }
}
