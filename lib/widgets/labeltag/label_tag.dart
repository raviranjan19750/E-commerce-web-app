import 'package:flutter/material.dart';

class LabelTag extends StatelessWidget {
  final String labeltext;

  const LabelTag(this.labeltext);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
          Container(
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
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    // path.moveTo(size.width * 0.67, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.90, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}
