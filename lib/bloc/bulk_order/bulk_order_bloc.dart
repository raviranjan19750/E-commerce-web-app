import 'package:bloc/bloc.dart';
part 'bulk_order_state.dart';
part 'bulk_order_event.dart';


class BulkOrderBloc extends Bloc<BulkOrderEvent,BulkOrderState>{

  BulkOrderBloc(BulkOrderState initialState) : super(initialState);

  @override
  Stream<BulkOrderState> mapEventToState(BulkOrderEvent event)
  async* {

    if(event is LoadBulkOrder){
      yield* loadInitialScreen(event);
    }

  }

  Stream<BulkOrderState> loadInitialScreen(LoadBulkOrder event) async* {




  }


}