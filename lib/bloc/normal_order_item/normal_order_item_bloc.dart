import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';

import '../../models/models.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
part 'normal_order_item_event.dart';
part 'normal_order_item_state.dart';

class NormalOrderItemBloc
    extends Bloc<NormalOrderItemEvent, NormalOrderItemState> {
  final NormalOrderRepository normalOrderRepository;
  final OrderedProduct orderedProduct;
  final NormalOrderBloc normalOrderBloc;

  NormalOrderItemBloc({
    this.normalOrderBloc,
    this.normalOrderRepository,
    this.orderedProduct,
  })  : assert(normalOrderBloc != null),
        assert(normalOrderRepository != null),
        assert(orderedProduct != null),
        super(NormalOrderItemInitial(
            orderedProduct, NormalOrderItemStateType.INITIAL));

  @override
  Stream<NormalOrderItemState> mapEventToState(
      NormalOrderItemEvent event) async* {
    if (event is AddRatingNormalOrders) {
      yield* addRatingNormalOrder(event, state);
    } else if (event is EditRatingNormalOrders) {
      yield* editRatingNormalOrder(event, state);
    } else if (event is LoadAddRatingDialogueEvent) {
      yield LaunchAddRatingDialogueState(
        state.orderedProduct,
        NormalOrderItemStateType.SUCCESS,
      );
    } else if (event is LoadEditRatingDialogueEvent) {
      yield LaunchEditRatingDialogueState(
        state.orderedProduct,
        NormalOrderItemStateType.SUCCESS,
      );
    }
  }

  Stream<NormalOrderItemState> addRatingNormalOrder(
      AddRatingNormalOrders event, NormalOrderItemState state) async* {
    yield NormalOrderItemUpdate(
        state.orderedProduct, NormalOrderItemStateType.LOADING);
    try {
      await normalOrderRepository.addNormalOrderRatingDetails(
        authID: event.authID,
        orderID: event.orderID,
        productID: event.productID,
        variantID: event.variantID,
        rating: event.rating,
        review: event.review,
      );
      state.orderedProduct.rating = event.rating;
      state.orderedProduct.review = event.review;
      normalOrderBloc.add(RefreshOrder());
      yield NormalOrderItemUpdate(
          state.orderedProduct, NormalOrderItemStateType.SUCCESS);
    } catch (e) {
      yield NormalOrderItemUpdate(
          state.orderedProduct, NormalOrderItemStateType.FAILURE);
    }
  }

  Stream<NormalOrderItemState> editRatingNormalOrder(
      EditRatingNormalOrders event, NormalOrderItemState state) async* {
    yield NormalOrderItemUpdate(
        state.orderedProduct, NormalOrderItemStateType.LOADING);
    try {
      await normalOrderRepository.editNormalOrderRatingDetails(
        key: event.key,
        previousRating: event.previousRating,
        productID: event.productID,
        rating: event.rating,
        review: event.review,
      );
      state.orderedProduct.rating = event.rating;
      state.orderedProduct.review = event.review;
      normalOrderBloc.add(RefreshOrder());
      yield NormalOrderItemUpdate(
          state.orderedProduct, NormalOrderItemStateType.SUCCESS);
    } catch (e) {
      yield NormalOrderItemUpdate(
          state.orderedProduct, NormalOrderItemStateType.FAILURE);
    }
  }
}
