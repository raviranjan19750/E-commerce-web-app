import 'package:bloc/bloc.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'normal_order_event.dart';
part 'normal_order_state.dart';

class NormalOrderBloc extends Bloc<NormalOrderEvent, NormalOrderState> {
  final NormalOrderRepository normalOrderRepository;
  NormalOrderBloc({this.normalOrderRepository})
      : super(NormalorderDetailInitial());

  @override
  Stream<NormalOrderState> mapEventToState(
    NormalOrderEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllNormalOrders) {
      yield* loadNormalOrderDetail(event);
    }
  }

  Stream<NormalOrderState> loadNormalOrderDetail(
      LoadAllNormalOrders event) async* {
    yield NormalOrderDetailLoading();

    try {
      List<Order> order =
          await normalOrderRepository.getNormalOrderDetails(event.authID);

      yield NormalOrderDetailLoadingSuccessful(order);
    } catch (e) {
      yield NormalOrderDetailLoadingFailure();
    }
  }
}
