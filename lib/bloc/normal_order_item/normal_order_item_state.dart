part of 'normal_order_item_bloc.dart';

enum NormalOrderItemStateType { INITIAL, LOADING, UPDATING, SUCCESS, FAILURE }

abstract class NormalOrderItemState {
  final OrderedProduct orderedProduct;
  final NormalOrderItemStateType type;

  NormalOrderItemState(
    this.orderedProduct,
    this.type,
  );
}

class NormalOrderItemInitial extends NormalOrderItemState {
  NormalOrderItemInitial(
    OrderedProduct orderedProduct,
    NormalOrderItemStateType type,
  ) : super(orderedProduct, type);
}

class NormalOrderItemUpdate extends NormalOrderItemState {
  NormalOrderItemUpdate(
    OrderedProduct orderedProduct,
    NormalOrderItemStateType type,
  ) : super(orderedProduct, type);
}

class ManageDialogueState extends NormalOrderItemState {
  ManageDialogueState(
    OrderedProduct orderedProduct,
    NormalOrderItemStateType type,
  ) : super(orderedProduct, type);
}

class LaunchAddRatingDialogueState extends ManageDialogueState {
  LaunchAddRatingDialogueState(
    OrderedProduct orderedProduct,
    NormalOrderItemStateType type,
  ) : super(orderedProduct, type);
}

class LaunchEditRatingDialogueState extends ManageDialogueState {
  LaunchEditRatingDialogueState(
    OrderedProduct orderedProduct,
    NormalOrderItemStateType type,
  ) : super(orderedProduct, type);
}
