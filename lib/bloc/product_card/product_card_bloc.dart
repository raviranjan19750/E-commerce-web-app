import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/comboProduct.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
part 'product_card_event.dart';
part 'product_card_state.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  final Product product;
  final ProductDetail productDetail;
  final ComboProduct comboProduct;
  final CustomerDetailRepository customerRepo;
  final WishlistConfigBloc wishlistBloc;
  final AuthenticationBloc auth;

  ProductCardBloc(
      {this.product,
      this.productDetail,
      this.comboProduct,
      this.customerRepo,
      this.wishlistBloc,
      this.auth})
      : assert(product != null || productDetail != null || comboProduct != null),
        assert(customerRepo != null),
        assert(wishlistBloc != null),
        super(ProductCardInitial(
            product,
            product != null ? customerRepo.contains(product.varientId) : (productDetail != null ? customerRepo.contains(productDetail.variantID) : customerRepo.contains(comboProduct.productId))));

  @override
  Stream<ProductCardState> mapEventToState(
    ProductCardEvent event,
  ) async* {
    if (event is AddToWishListProductEvent) {
      String uid;
      if (auth.state.user != null && !auth.state.user.isAnonymous) {
        uid = auth.state.user.uid;
      }

      if(productDetail != null) {
        customerRepo.addToWishList(productDetail.productID, productDetail.variantID, authID: uid);
        yield UpdatedProductCard(productDetail, true);
        wishlistBloc.add(UpdateWishConfigList());
      }
      else if(comboProduct != null) {
        customerRepo.addToWishList(comboProduct.productId, comboProduct.productId, authID: uid);
        yield UpdatedProductCard(comboProduct, true);
        wishlistBloc.add(UpdateWishConfigList());
      }
      else {
        customerRepo.addToWishList(product.productId, product.varientId, authID: uid);
        yield UpdatedProductCard(product, true);
        wishlistBloc.add(UpdateWishConfigList());
      }

    } else if (event is RemoveFromWishListProductEvent) {

      if(productDetail != null) {
        customerRepo.removeFromWishList(productDetail.variantID);
        yield UpdatedProductCard(productDetail, false);
        wishlistBloc.add(UpdateWishConfigList());
      }
      else if (comboProduct != null) {
        customerRepo.removeFromWishList(comboProduct.productId);
        yield UpdatedProductCard(comboProduct, false);
        wishlistBloc.add(UpdateWishConfigList());
      }
      else{
        customerRepo.removeFromWishList(product.varientId);
        yield UpdatedProductCard(product, false);
        wishlistBloc.add(UpdateWishConfigList());

      }


    }
  }
}
