import 'package:flutter/material.dart';
import './models.dart';

class Rating {
  final String orderID;
  final String authID;
  final double rating;
  final List<Review> reviews;

  Rating({
    this.orderID,
    this.authID,
    this.rating,
    this.reviews,
  });
}
