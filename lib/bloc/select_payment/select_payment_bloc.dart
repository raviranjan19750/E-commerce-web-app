import 'package:flutter_bloc/flutter_bloc.dart';
part 'select_payment_event.dart';
part 'select_payment_state.dart';

class SelectPaymentBloc extends Bloc<SelectPaymentEvent, SelectPaymentState> {
  SelectPaymentBloc() : super(null);

  @override
  Stream<SelectPaymentState> mapEventToState(
    SelectPaymentEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetSelectPayment) {
      yield LoadSelectPayment(event.paymentMode);
    } else if (event is LoadSelectPaymentDialog) {
      yield LaunchSelectPaymentDialog();
    }
  }
}
