import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class OrderScreenDesktop extends StatefulWidget {
  // Desktop Website Order Screen
  final TrackingScrollController scrollController;

  const OrderScreenDesktop({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  _OrderScreenDesktopState createState() => _OrderScreenDesktopState();
}

class _OrderScreenDesktopState extends State<OrderScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NormalOrderBloc(
                normalOrderRepository: RepositoryProvider.of(context))
              ..add(LoadAllNormalOrders('id1'))),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonList(
                isMyOrderSelected: true,
              ),
              Expanded(child: NormalOrdersContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
