import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class AppBarSearchBar extends StatefulWidget {
  //TODO: Make a Search Icon
  @override
  _AppBarSearchBarState createState() => _AppBarSearchBarState();
}

class _AppBarSearchBarState extends State<AppBarSearchBar> {
  TextEditingController _searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    // Addding listener to search controller
    _searchController.addListener(() {
      print(_searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Search Bar
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: Strings.searchBar,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
