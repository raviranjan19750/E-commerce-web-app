import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'scroll_event.dart';
part 'scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  final ScrollController controller;

  ScrollBloc({this.controller})
      : assert(controller != null),
        super(ScrollInitial());

  @override
  Stream<ScrollState> mapEventToState(
    ScrollEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
