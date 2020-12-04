import 'package:flutter/material.dart';
import 'package:living_desire/data/data.dart';
import '../../config/configs.dart';
import 'package:rating_bar/rating_bar.dart';
import '../../models/models.dart';

class RatingContainer extends StatefulWidget {
  @override
  _RatingContainerState createState() => _RatingContainerState();
}

class _RatingContainerState extends State<RatingContainer> {
  // Text Editing Review Controller
  TextEditingController _reviewController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    // Addding listener to review controller
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
    final List<Rating> ratings = rating;
    return Container(
      child: Column(
        children: [
          // Rating Bar Order
          //TODO: Get Aggregate rating
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
            child: Text(Strings.rate),
            onPressed: () {
              // Dialog Box
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Close Button
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
                            // Raview Text
                            Text(Strings.reviewFeed),
                            // Review Container For differnt Products
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    //TODO: Get Review Based on the order id
                                    // Match the order id to the review
                                    ...ratings[0].reviews.map((e) {
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
                                            // Product Name
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Palette.maroon,
                                              ),
                                              child: Text(
                                                //TODO: Get Product Name from productID
                                                e.productID,
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
                                                  //TODO: Product Image
                                                  Text('Product Image'),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        RatingBar(
                                                          //TODO: Get correct Rating based on product ID
                                                          initialRating:
                                                              e.rating,
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
                                    }),
                                  ],
                                ),
                                // child: ListView.builder(
                                //   //TODO: Get Review Based on the order id
                                //   // Match the order id to the review
                                //   itemCount: ratings[0].reviews.length,
                                //   itemBuilder: (context, index) {
                                //     return Container(
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Divider(
                                //             color: Colors.black,
                                //             thickness: 0.5,
                                //           ),
                                //           // Product Name
                                //           Container(
                                //             padding: EdgeInsets.symmetric(
                                //                 vertical: 10.0,
                                //                 horizontal: 12.0),
                                //             decoration: BoxDecoration(
                                //               shape: BoxShape.rectangle,
                                //               color: Palette.maroon,
                                //             ),
                                //             child: Text(
                                //               //TODO: Get Product Name from productID
                                //               ratings[0]
                                //                   .reviews[index]
                                //                   .productID,
                                //               style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //                 fontSize: 16,
                                //                 color: Colors.white,
                                //               ),
                                //             ),
                                //           ),
                                //           Container(
                                //             child: Row(
                                //               children: [
                                //                 //TODO: Product Image
                                //                 Text('Product Image'),
                                //                 Container(
                                //                   child: Column(
                                //                     children: [
                                //                       RatingBar(
                                //                         //TODO: Get correct Rating based on product ID
                                //                         initialRating:
                                //                             ratings[0]
                                //                                 .reviews[index]
                                //                                 .rating,
                                //                         onRatingChanged:
                                //                             (rating) {},
                                //                         filledIcon: Icons.star,
                                //                         emptyIcon:
                                //                             Icons.star_border,
                                //                         isHalfAllowed: false,
                                //                         filledColor:
                                //                             Colors.yellow,
                                //                         emptyColor:
                                //                             Colors.black12,
                                //                         size: 40,
                                //                       ),

                                //                       // TextField(
                                //                       //   controller:
                                //                       //       _reviewController,
                                //                       // ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            ),
                            // Submit Button
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
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      // Submit Button
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          Strings.submit,
                                          style: TextStyle(color: Colors.white),
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
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
