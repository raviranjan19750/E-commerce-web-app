import 'package:bloc/bloc.dart';
import 'package:living_desire/models/models.dart';
part 'manage_addresses_event.dart';
part 'manage_addresses_state.dart';

class ManageAddressesBloc
    extends Bloc<ManageAddressesEvent, ManageAddresesState> {
  ManageAddressesBloc() : super(AddressDetailInitial());

  @override
  Stream<ManageAddresesState> mapEventToState(
    ManageAddressesEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllAddresses) {
      yield* loadAddressDetail(event);
    }
    throw UnimplementedError();
  }
}

Stream<ManageAddresesState> loadAddressDetail(LoadAllAddresses event) async* {
  List<Address> addresses;

  yield AddressDetailLoading();

  try {
    await Future.delayed(Duration(seconds: 2));

    yield AddressDetailLoadingSuccessful(addresses);
  } catch (e) {
    yield AddressDetailLoadingFailure();
  }
}
