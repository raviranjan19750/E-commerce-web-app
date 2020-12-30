import 'package:flutter/material.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';

class CustomWidget extends StatelessWidget {
  final String txt;
  final List<String> urls;
  const CustomWidget(this.txt, this.urls);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ),
        LabelTag(txt),
        Container(
          height: 250,
          child: Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.urls.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      // child: ProductCard(product: ,)
                      child: Container(
                        color: Colors.blue,
                      ));
                }),
          ),
          // child: ListView(),
        ),

        // ProductCard(
        //   product: "Product 1",
        //   url: urls[0],
        // )
      ],
    );
  }
}

class LabelTag extends StatelessWidget {
  final String labeltext;

  const LabelTag(this.labeltext);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.025,
        // width: MediaQuery.of(context).size.width * 0.08,
        height: 30,
        width: 120,
        decoration: BoxDecoration(color: Color.fromARGB(255, 184, 68, 68)),
        child: Center(
          child: Text(
            this.labeltext,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(0.0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
