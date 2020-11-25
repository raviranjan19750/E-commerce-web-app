import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:rating_bar/rating_bar.dart';

class RatingContainer extends StatefulWidget {
  @override
  _RatingContainerState createState() => _RatingContainerState();
}

class _RatingContainerState extends State<RatingContainer> {
  TextEditingController _reviewController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    // Addding listener to search controller
    _reviewController.addListener(() {
      print(_reviewController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RatingBar(
            onRatingChanged: (rating) {},
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            isHalfAllowed: false,
            filledColor: Colors.yellow,
            emptyColor: Colors.black12,
            size: 20,
          ),
          FlatButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                      child: Icon(
                                        Icons.close,
                                        size: 15.0,
                                      ),
                                      shape: CircleBorder(),
                                    ),
                                  ],
                                ),
                              ),
                              Text('Review and Feed back'),
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: Colors.black,
                                              thickness: 0.5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Palette.maroon,
                                              ),
                                              child: Text(
                                                'Product Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  // Product Image
                                                  Text('Product Image'),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        RatingBar(
                                                          onRatingChanged:
                                                              (rating) {},
                                                          filledIcon:
                                                              Icons.star,
                                                          emptyIcon:
                                                              Icons.star_border,
                                                          isHalfAllowed: false,
                                                          filledColor:
                                                              Colors.yellow,
                                                          emptyColor:
                                                              Colors.black12,
                                                          size: 40,
                                                        ),

                                                        // TextField(
                                                        //   controller:
                                                        //       _reviewController,
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Palette.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        // Submit Button
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            'Submit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Text('Rate & Review'),
          ),
        ],
      ),
    );
  }
}
