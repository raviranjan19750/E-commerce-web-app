import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/models/models.dart';
part 'select_address_event.dart';

part 'select_address_state.dart';

class SelectAddressBloc extends Bloc<SelectAddressEvent, SelectAddressState> {
  SelectAddressBloc() : super(null);

  @override
  Stream<SelectAddressState> mapEventToState(
    SelectAddressEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAddress) {
      yield SelectAddressDetailLoadingSuccessful(event.address);
    }
  }
}
