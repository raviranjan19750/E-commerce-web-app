import 'package:flutter/material.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import 'package:living_desire/bloc/normal_order_item/normal_order_item_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:rating_bar/rating_bar.dart';

class RatingDialogContainer extends StatefulWidget {
  final OrderedProduct orderedProduct;
  final Function onActionButton;
  final bool isAddRating;
  final bool isEditrating;
  final String orderID;
  var authID;

  RatingDialogContainer({
    Key key,
    this.isAddRating = false,
    this.orderID,
    this.isEditrating = false,
    this.onActionButton,
    this.orderedProduct,
    this.authID = 'id1',
  }) : super(key: key);

  @override
  _RatingDialogContainerState createState() => _RatingDialogContainerState();
}

class _RatingDialogContainerState extends State<RatingDialogContainer> {
  String review;
  double previousRating;
  double rating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.orderedProduct.rating != null) {
      review = widget.orderedProduct.review;
      previousRating = widget.orderedProduct.rating;
    } else {
      review = '';
      previousRating = 0.0;
      rating = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.orderedProduct.productName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.orderedProduct.imageUrl,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar(
                              onRatingChanged: (ratingValue) {
                                rating = ratingValue;
                              },
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              isHalfAllowed: false,
                              initialRating: previousRating,
                              filledColor: Colors.yellow[700],
                              emptyColor: Colors.black12,
                              size: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    labelText: Strings.writeReview,
                                    //border: InputBorder.none,
                                    labelStyle: TextStyle(color: Colors.blue),
                                    // focusedBorder: InputBorder.none,
                                    // enabledBorder: InputBorder.none,
                                    // errorBorder: InputBorder.none,
                                    // disabledBorder: InputBorder.none,
                                  ),
                                  cursorColor: Colors.black,
                                  initialValue: review,
                                  // validator: validator,
                                  //onSaved: (review) {},
                                  onChanged: (reviewValue) {
                                    review = reviewValue;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      elevation: 10.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            Strings.cancel,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                widget.isAddRating
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            print('Submit button');
                            widget.onActionButton(AddRatingNormalOrders(
                              authID: widget.authID,
                              productID: widget.orderedProduct.productID,
                              variantID: widget.orderedProduct.variantID,
                              orderID: widget.orderID,
                              rating: rating,
                              review: review,
                            ));
                          },
                          child: Material(
                            elevation: 10.0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.1,
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  Strings.submit,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                widget.isEditrating
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            widget.onActionButton(EditRatingNormalOrders(
                              productID: widget.orderedProduct.productID,
                              key: widget.orderedProduct.ratingID,
                              previousRating: widget.orderedProduct.rating,
                              rating: rating,
                              review: review,
                            ));
                          },
                          child: Material(
                            elevation: 10.0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.1,
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  Strings.edit,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
