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
    } else if (event is LoadAddAddressDialogueEvent) {
      yield LaunchAddNewAddressDialogueState();
    } else if (event is DeleteAddress) {
      yield* deleteAddressDetails(event);
    } else if (event is DefaultAddress) {
      yield* defaultAddressDetails(event);
    } else if (event is UpdateAddress) {
      yield* updateAddressDetails(event);
    } else if (event is LoadEditAddressDialogueEvent) {
      yield LaunchEditAddressDialogueState(event.address);
    }
  }

  //Load All Address Details
  Stream<ManageAddresesState> loadAddressDetail(LoadAllAddresses event) async* {
    yield AddressDetailLoading();

    try {
      List<Address> addresses =
          await addresssRepository.getAddressDetails(event.authID);
      // var response = await addresssRepository.addAddressDetails(
      //   event.authID,
      //   "event.address",
      //   "event.pincode",
      //   "event.phone",
      //   "event.name",
      // );
      yield AddressDetailLoadingSuccessful(addresses);
    } catch (e) {
      print(e.toString());
      yield AddressDetailLoadingFailure();
    }
  }

  //Add an Address Detail
  Stream<ManageAddresesState> addAddressDetails(AddAddress event) async* {
    yield AddAddressDetailLoading();
    try {
      await addresssRepository.addAddressDetails(
        event.authID,
        event.address,
        event.pincode,
        event.phone,
        event.name,
      );

      yield* loadAddressDetail(LoadAllAddresses(event.authID));
    } catch (e) {
      yield AddAddressDetailLoadingFailure();
    }
  }

  // Update an Address Detail
  Stream<ManageAddresesState> updateAddressDetails(UpdateAddress event) async* {
    yield UpdateAddressDetailLoading();
    try {
      await addresssRepository.updateAddressDetails(
        event.key,
        event.address,
        event.pincode,
        event.phone,
        event.name,
      );
      yield* loadAddressDetail(LoadAllAddresses(event.authID));
    } catch (e) {
      yield UpdateAddressDetailLoadingFailure();
    }
  }

  // Delete an Address Detail
  Stream<ManageAddresesState> deleteAddressDetails(DeleteAddress event) async* {
    yield DeleteAddressDetailLoading();
    try {
      await addresssRepository.deleteAddressDetails(
        event.key,
        event.authID,
      );
      yield* loadAddressDetail(LoadAllAddresses(event.authID));
    } catch (e) {
      yield DeleteAddressDetailLoadingFailure();
    }
  }

  //Set an Address Detail as Default
  Stream<ManageAddresesState> defaultAddressDetails(
      DefaultAddress event) async* {
    yield DefaultAddressDetailLoading();
    try {
      await addresssRepository.defaultAddressDetails(
        event.key,
        event.authID,
      );
      yield* loadAddressDetail(LoadAllAddresses(event.authID));
    } catch (e) {
      yield DefaultAddressDetailLoadingFailure();
    }
  }
}
