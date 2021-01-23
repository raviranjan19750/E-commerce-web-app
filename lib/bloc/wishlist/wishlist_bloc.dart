import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/models/localwishlist.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
import 'package:hive/hive.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;
  final WishlistConfigBloc configBloc;
  WishlistBloc({this.wishlistRepository, this.configBloc})
      : super(WishlistDetailInitial());

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is LoadAllWishlist) {
      yield* loadWishlistDetail(event);
    } else if (event is DeleteWishlist) {
      yield* deleteWishlistDetail(event);
    }
  }

  // Load Wishlist Detail
  Stream<WishlistState> loadWishlistDetail(LoadAllWishlist event) async* {
    yield WishlistDetailLoading();

    try {
      if (event.authID != null) {
        List<Wishlist> wishlist =
            await wishlistRepository.getWishlistDetails(event.authID);
        configBloc.add(UpdateWishList(wishlist));
        yield WishlistDetailLoadingSuccessful(wishlist);
      } else {
        final _wishlist = Hive.box<WishlistLocal>('wishlist_items');

        Map<dynamic, WishlistLocal> wsh = _wishlist.toMap();
        var data = [];
        var keys = [];
        wsh.forEach((key, value) {
          var keyData = {
            "key": key,
            "variantID": value.variantID,
          };
          keys.add(keyData);
          var wishlistData = {
            "productID": value.productID,
            "variantID": value.variantID
          };
          data.add(wishlistData);
        });
        final response = await CloudFunctionConfig.post(
            'manageAnonymousUser/get-wishlist', data);
        if (response.statusCode == 200) {
          List<Wishlist> wishlist =
              (jsonDecode(response.body) as List).map((e) {
            for (int i = 0; i < keys.length; i++) {
              if (e['variantID'] == (keys[i])["variantID"]) {
                return Wishlist.fromJsonMap(e, (keys[i])["key"]);
              }
            }
          }).toList();
          configBloc.add(UpdateWishList(wishlist));
          yield WishlistDetailLoadingSuccessful(wishlist);
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield WishlistDetailLoadingFailure();
    }
  }

  // TODO: Make Wishlist add to cart function:
  //To add wishlist to the cart: cartrepository.addCartDetails then
  // Delete Wishlist: remove from cart

  static const AUTO_ID_ALPHABET =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static const AUTO_ID_LENGTH = 20;
  String _getAutoId() {
    final buffer = StringBuffer();
    final random = Random.secure();

    final maxRandom = AUTO_ID_ALPHABET.length;

    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      buffer.write(AUTO_ID_ALPHABET[random.nextInt(maxRandom)]);
    }
    return buffer.toString();
  }

  // Add Wishlist Detail
  Stream<WishlistState> addWishlistDetail(AddWishlist event) async* {
    yield AddWishlistDetailLoading();

    try {
      if (event.authID != null) {
        await wishlistRepository.addWishlistDetails(
          event.authID,
          event.productID,
          event.variantID,
        );
        yield AddWishlistDetailLoadingSuccessful();
      } else {
        Wishlist itm = new Wishlist(
          key: _getAutoId(),
          productID: event.productID,
          variantID: event.variantID,
        );
        WishlistLocalStorage(itm).saveToLocalStorage();
        yield AddWishlistDetailLoadingSuccessful();
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield AddWishlistDetailLoadingFailure();
    }
  }

  //Delete a wishlist
  Stream<WishlistState> deleteWishlistDetail(DeleteWishlist event) async* {
    yield DeleteWishlistDetailLoading();

    try {
      if (event.authID != null) {
        await wishlistRepository.deleteWishlistDetails(
          event.key,
          event.productID,
          event.authID,
        );

        yield* loadWishlistDetail(LoadAllWishlist(event.authID));
      } else {
        Wishlist itm = new Wishlist(
          key: event.key,
          productID: event.productID,
        );
        WishlistLocalStorage(itm).deleteFromLocalStorage(event.key);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield DeleteWishlistDetailLoadingFailure();
    }
  }
}
