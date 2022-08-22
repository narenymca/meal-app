import 'package:flutter/material.dart';
import 'package:meal/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/Filter-screen';
  final Function saveFilter;
  final Map<String, bool> currentFilters;
  FilterScreen(
      {Key key, @required this.saveFilter, @required this.currentFilters})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _gutenFree = false;
  var _vegetarain = false;
  var _vegan = false;
  var _lactose = false;

  @override
  void initState() {
    _gutenFree = widget.currentFilters['gluten'];
    _lactose = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarain = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListViewTile(
      String title, String subtitle, bool switchValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: switchValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilter = {
                'gluten': _gutenFree,
                'lactose': _lactose,
                'vegan': _vegan,
                'vegetarian': _vegetarain,
              };
              widget.saveFilter(selectedFilter);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Adjust your meal selection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListViewTile(
                    'Gluten Free', 'The Meals are Gluten Free', _gutenFree,
                    (value) {
                  setState(() {
                    _gutenFree = value;
                  });
                }),
                _buildSwitchListViewTile(
                    'Lactose Free', 'The Meals are Lactose Free', _lactose,
                    (value) {
                  setState(() {
                    _lactose = value;
                  });
                }),
                _buildSwitchListViewTile(
                    'Vegetarian', 'The Meals are Vegetarian', _vegetarain,
                    (value) {
                  setState(() {
                    _vegetarain = value;
                  });
                }),
                _buildSwitchListViewTile(
                    'Vegan', 'The Meals are Vegan Free', _vegan, (value) {
                  setState(() {
                    _vegan = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
