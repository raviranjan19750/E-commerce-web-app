import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/address_repository.dart';
import 'package:living_desire/models/models.dart';
part 'manage_addresses_event.dart';
part 'manage_addresses_state.dart';

class ManageAddressesBloc
    extends Bloc<ManageAddressesEvent, ManageAddresesState> {
  final AddresssRepository addresssRepository;
  ManageAddressesBloc({this.addresssRepository})
      : super(AddressDetailInitial());

  @override
  Stream<ManageAddresesState> mapEventToState(
    ManageAddressesEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllAddresses) {
      yield* loadAddressDetail(event);
    } else if (event is AddAddress) {
      yield* addAddressDetails(event);
    }
  }

  Stream<ManageAddresesState> loadAddressDetail(LoadAllAddresses event) async* {
    yield AddressDetailLoading();

    try {
      List<Address> addresses =
          await addresssRepository.getAddressDetails(event.authID);

      yield AddressDetailLoadingSuccessful(addresses);
    } catch (e) {
      yield AddressDetailLoadingFailure();
    }
  }

  Stream<ManageAddresesState> addAddressDetails(AddAddress event) async* {
    yield AddAddressDetailLoading();
    yield AddAddressDetailLoadingSuccesfull();
  }
}
