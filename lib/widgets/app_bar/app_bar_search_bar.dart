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
      child: Container(

        padding: EdgeInsets.only(left: 16,right: 8),

        decoration: BoxDecoration(

          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),


          
        ),
        
        child: TextField(

          textAlignVertical: TextAlignVertical.center,
          cursorColor: Palette.secondaryColor,
          controller: _searchController,

          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: Strings.searchBar,
            focusColor: Palette.secondaryColor,
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
