part of 'normal_order_item_bloc.dart';

abstract class NormalOrderItemEvent extends Equatable {
  const NormalOrderItemEvent();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AddRatingNormalOrders extends NormalOrderItemEvent {
  final String key;
  final String authID;
  final String variantID;
  final String orderID;
  final String productID;
  final String review;
  final double rating;

  AddRatingNormalOrders({
    this.key,
    this.productID,
    this.authID,
    this.orderID,
    this.variantID,
    this.review,
    this.rating,
  });
}

class EditRatingNormalOrders extends NormalOrderItemEvent {
  final String key;
  final double previousRating;

  final String productID;

  final String review;
  final double rating;

  EditRatingNormalOrders({
    this.key,
    this.productID,
    this.previousRating,
    this.review,
    this.rating,
  });
}

class RatingDialogueEvent extends NormalOrderItemEvent {}

class LoadAddRatingDialogueEvent extends RatingDialogueEvent {}

class LoadEditRatingDialogueEvent extends RatingDialogueEvent {
  final OrderedProduct orderedProduct;

  LoadEditRatingDialogueEvent({this.orderedProduct});
}
