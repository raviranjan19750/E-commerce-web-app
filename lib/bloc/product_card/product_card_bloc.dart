import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';

part 'product_card_event.dart';
part 'product_card_state.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  final Product product;
  final CustomerDetailRepository customerRepo;
  final WishlistConfigBloc wishlistBloc;

  ProductCardBloc({this.product, this.customerRepo, this.wishlistBloc})
      : assert(product != null),
        assert(customerRepo != null),
        assert(wishlistBloc != null),
        super(ProductCardInitial(
            product, customerRepo.contains(product.varientId)));

  @override
  Stream<ProductCardState> mapEventToState(
    ProductCardEvent event,
  ) async* {
    if (event is AddToWishListProductEvent) {
      customerRepo.addToWishList(product.varientId);
      yield UpdatedProductCard(product, true);
      wishlistBloc.add(UpdateWishConfigList());
    } else if (event is RemoveFromWishListProductEvent) {
      customerRepo.removeFromWishList(product.varientId);
      yield UpdatedProductCard(product, false);
      wishlistBloc.add(UpdateWishConfigList());
    }
  }
}
