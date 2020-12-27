class Rating {
  double rating;
  String review;
  final String key;

  Rating({
    this.rating,
    this.key,
    this.review,
  });

  factory Rating.fromJson(dynamic data) {
    if (data == null) return null;

    return Rating(
      rating: data['rating'],
      review: data['review'],
      key: data['ratingID'],
    );
  }
}
