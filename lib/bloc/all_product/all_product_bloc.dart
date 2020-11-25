import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  AllProductBloc() : super(AllProductInitial());

  @override
  Stream<AllProductState> mapEventToState(
    AllProductEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
