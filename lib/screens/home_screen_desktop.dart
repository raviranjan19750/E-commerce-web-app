import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../config/configs.dart';

class HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy List Data for Products
    // Later Connect to Firebase
    List<String> lproducts = ["Product 1", "Product 2", "Combos"];
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Why us? Button
                  FlatButton(
                    onPressed: () {},
                    child: Text(Strings.whyUs),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  // For Offices Button
                  FlatButton(
                    onPressed: () {},
                    child: Text(Strings.forOffices),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  // For Property Button
                  FlatButton(
                    onPressed: () {},
                    child: Text(Strings.forProperty),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  // For Home Button
                  FlatButton(
                    onPressed: () {},
                    child: Text(Strings.forHome),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    // Item Count Connect to firebase
                    itemCount: lproducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductsCategory(productName: lproducts[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
