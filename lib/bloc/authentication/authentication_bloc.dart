import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/bloc/cart_config/cart_config_bloc.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
import 'package:living_desire/models/user.dart';
import 'package:living_desire/models/user_detail.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final WishlistConfigBloc wishlistConfigBloc;
  final CartConfigBloc cartConfigBloc;

  AuthenticationBloc(
      {@required AuthenticationRepository authenticationRepository,
      this.wishlistConfigBloc, this.cartConfigBloc})
      : assert(authenticationRepository != null),
        assert(cartConfigBloc != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logout());
    } else if (event is ReloadAuthenticatedUser) {
      _authenticationRepository.reloadUser();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    if (event.user != null) {
      wishlistConfigBloc.add(GetWishlistFromServer(event.user.uid));
      cartConfigBloc.add(GetCartItemsFromServer(event.user.uid));
    } else {
      wishlistConfigBloc.add(ResetWishList());
      cartConfigBloc.add(ResetCartList());
    }

    return event.user != null
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }
}
