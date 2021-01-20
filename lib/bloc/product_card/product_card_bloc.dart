import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/cart_config/cart_config_bloc.dart';
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
  final CartConfigBloc cartConfigBloc;
  final AuthenticationBloc auth;

  ProductCardBloc(
      {this.product,
      this.productDetail,
      this.comboProduct,
      this.customerRepo,
      this.wishlistBloc,
      this.cartConfigBloc,
      this.auth})
      : assert(
            product != null || productDetail != null || comboProduct != null),
        assert(customerRepo != null),
        assert(wishlistBloc != null),
        assert(cartConfigBloc != null),
        super(ProductCardInitial(
            (product != null)
                ? product
                : ((productDetail != null) ? productDetail : comboProduct),
            product != null
                ? customerRepo.alreadyInWishlist(product.varientId)
                : (productDetail != null
                    ? customerRepo.alreadyInWishlist(productDetail.variantID)
                    : customerRepo.alreadyInWishlist(comboProduct.productId)),
            product != null
                ? customerRepo.alreadyInCart(
                    product.productId, product.varientId)
                : (productDetail != null
                    ? customerRepo.alreadyInCart(
                        productDetail.productID, productDetail.variantID)
                    : customerRepo.alreadyInCart(
                        comboProduct.productId, comboProduct.productId))));

  @override
  Stream<ProductCardState> mapEventToState(
    ProductCardEvent event,
  ) async* {
    if (event is AddToWishListProductEvent) {
      String uid;
      if (auth.state.user != null && !auth.state.user.isAnonymous) {
        uid = auth.state.user.uid;
      }

      if (productDetail != null) {
        await customerRepo.addToWishList(
            productDetail.productID, productDetail.variantID,
            authID: uid);
        yield UpdatedProductCard(productDetail, true, state.isItemInCart);
      } else if (comboProduct != null) {
        await customerRepo.addToWishList(
            comboProduct.productId, comboProduct.productId,
            authID: uid);
        yield UpdatedProductCard(comboProduct, true, state.isItemInCart);
      } else {
        await customerRepo.addToWishList(product.productId, product.varientId,
            authID: uid);
        yield UpdatedProductCard(product, true, state.isItemInCart);
      }
    } else if (event is RemoveFromWishListProductEvent) {
      if (productDetail != null) {
        await customerRepo.removeFromWishList(productDetail.variantID);
        yield UpdatedProductCard(productDetail, false, state.isItemInCart);
      } else if (comboProduct != null) {
        await customerRepo.removeFromWishList(comboProduct.productId);
        yield UpdatedProductCard(comboProduct, false, state.isItemInCart);
      } else {
        await customerRepo.removeFromWishList(product.varientId);
        yield UpdatedProductCard(product, false, state.isItemInCart);
      }

    } else if (event is AddToCartEvent) {
      if (auth.state.user.uid != null) {
        if (productDetail != null) {
          await customerRepo.addToCart(
              authID: auth.state.user.uid,
              productID: productDetail.productID,
              variantID: product.varientId,
              quantity: 1);
          yield UpdatedProductCard(productDetail, state.isItemInWishList, true);
        } else if (comboProduct != null) {
          await customerRepo.addToCart(
              authID: auth.state.user.uid,
              productID: comboProduct.productId,
              variantID: comboProduct.productId,
              quantity: 1);
          yield UpdatedProductCard(comboProduct, state.isItemInWishList, true);
        } else {
          await customerRepo.addToCart(
              authID: auth.state.user.uid,
              productID: product.productId,
              variantID: product.varientId,
              quantity: 1);
          yield UpdatedProductCard(product, state.isItemInWishList, true);
        }
      }
    } else if (event is RemoveFromCartEvent) {}

    wishlistBloc.add(UpdateWishConfigList());
    cartConfigBloc.add(UpdateCartConfigList());
  }
}
