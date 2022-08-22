import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/categories_screen.dart';
import 'package:meal/screens/catergory_meals_screen.dart';
import 'package:meal/screens/filter_screen.dart';
import 'package:meal/screens/meal_detail_screen.dart';
import 'package:meal/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _avbleMeals = DUMMY_MEALS;

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _avbleMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _favoriteMeal = [];

  void _toggleFavorite(String favMealID) {
    final indexFavorite =
        _favoriteMeal.indexWhere((element) => element.id == favMealID);

    if (indexFavorite >= 0) {
      setState(() {
        _favoriteMeal.removeAt(indexFavorite);
      });
    } else {
      setState(() {
        _favoriteMeal
            .add(DUMMY_MEALS.firstWhere((element) => element.id == favMealID));
      });
    }
  }

  bool _isFavoMeal(String id) {
    return _favoriteMeal.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsBarScreen(favoriteMeal: _favoriteMeal),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(avblMeals: _avbleMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isFavoMeal: _isFavoMeal),
        FilterScreen.routeName: (context) =>
            FilterScreen(saveFilter: _setFilters, currentFilters: _filters),
      },
      // onGenerateRoute: (settings) {

      //   print(settings.name);
      //   if (settings.name == CategoryMealScreen.routeName) {
      //     return MaterialPageRoute(
      //       builder: (context) => CategoryMealScreen(),
      //     );
      //   }
      //   if (settings.name == MealDetailScreen.routeName) {
      //     final id = settings.arguments;
      //     return MaterialPageRoute(
      //       builder: (context) => MealDetailScreen(),
      //     );
      //   } else {
      //     return MaterialPageRoute(builder: (context) => CategoriesScreen());
      //   }
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
      //  home: CategoriesScreen(),
    );
  }
}
