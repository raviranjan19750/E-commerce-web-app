import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_bar_event.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(AppBarInitial());

  @override
  Stream<AppBarState> mapEventToState(
    AppBarEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
