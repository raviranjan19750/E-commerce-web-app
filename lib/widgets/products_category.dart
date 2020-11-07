import 'package:flutter/material.dart';

class ProductsCategory extends StatelessWidget {
  final String productName;

  const ProductsCategory({Key key, this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy Product Name
    List<String> litems = ["Item 1", "Item 2", "Item 3"];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(productName),
              const SizedBox(
                width: 10.0,
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        Container(
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: litems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  onPressed: () {
                    //Navigator.of(context).pushNamed(routeName);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 100.0,
                    color: Colors.red,
                    child: Column(
                      children: [
                        // Add Product Image from firebase

                        Text(litems[index]),
                        Text('price'),
                        // Add other Information
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
