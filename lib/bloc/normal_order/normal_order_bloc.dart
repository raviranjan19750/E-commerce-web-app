import 'package:bloc/bloc.dart';
import 'package:living_desire/bloc/normal_order_item/normal_order_item_bloc.dart';
import 'package:living_desire/logger.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
import '../bloc.dart';
part 'normal_order_event.dart';
part 'normal_order_state.dart';

class NormalOrderBloc extends Bloc<NormalOrderEvent, NormalOrderState> {
  final NormalOrderRepository normalOrderRepository;
  final NormalOrderItemBloc normalOrderItemBloc;
  NormalOrderBloc({this.normalOrderRepository, this.normalOrderItemBloc})
      : super(NormalorderDetailInitial());

  var LOG = LogBuilder.getLogger();

  @override
  Stream<NormalOrderState> mapEventToState(
    NormalOrderEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllNormalOrders) {
      yield* loadNormalOrderDetail(event);
    } else if (event is RefreshOrder) {
      yield NormalOrderDetailLoading();
      // await Future.delayed(Duration(milliseconds: 200));

      yield NormalOrderDetailLoadingSuccessful(
          normalOrderRepository.order.map((e) => e).toList());
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
