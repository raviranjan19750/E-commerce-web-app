import 'package:flutter/material.dart';

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
