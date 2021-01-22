import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/address_repository.dart';
import 'package:living_desire/models/models.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
part 'manage_addresses_event.dart';
part 'manage_addresses_state.dart';

class ManageAddressesBloc
    extends Bloc<ManageAddressesEvent, ManageAddresesState> {
  final AddressRepository addresssRepository;
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
    } else if (event is DefaultAddress) {
      yield* defaultAddressDetails(event);
    } else if (event is UpdateAddress) {
      yield* updateAddressDetails(event);
    } else if (event is LoadEditAddressDialogueEvent) {
      yield LaunchEditAddressDialogueState(event.address);
    } else if (event is LoadDeleteAddressDialogueEvent) {
      yield LaunchDeleteAddressDialogueState(event.address);
    }
  }

  //Load All Address Details
  Stream<ManageAddresesState> loadAddressDetail(LoadAllAddresses event) async* {
    yield AddressDetailLoading();

    try {
      List<Address> addresses =
          await addresssRepository.getAddressDetails(event.authID);

      yield AddressDetailLoadingSuccessful(addresses);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

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
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

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
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield UpdateAddressDetailLoadingFailure();
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
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield DefaultAddressDetailLoadingFailure();
    }
  }
}
