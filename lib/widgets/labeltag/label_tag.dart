import 'package:flutter/material.dart';

class LabelTag extends StatelessWidget {
  final String labeltext;

  const LabelTag(this.labeltext);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Wrap(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.025,
            // width: MediaQuery.of(context).size.width * 0.08,
            height: 35,
            padding: EdgeInsets.only(top: 8.0,  left: 16.0, right: 40.0),
            decoration: BoxDecoration(color: Color.fromARGB(255, 184, 68, 68)),
            child: Text(
              this.labeltext,
              style: TextStyle(color: Colors.white),
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