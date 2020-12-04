import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextListHover extends StatefulWidget {
  @override
  NextListHoverState createState() => NextListHoverState();
}

class NextListHoverState extends State<NextListHover> {
  bool isHover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },

        child:Container(

          child: Card(
            elevation: 4.0,
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),

            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,

                child: isHover? Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 28,
                ) : Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 24,
                ),
            ),
          ),
        ),

      ),
    );
  }
}