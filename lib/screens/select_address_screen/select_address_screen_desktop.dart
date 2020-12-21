import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class SelectAddressScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<Cart> cart;

  const SelectAddressScreenDesktop({
    Key key,
    this.scrollController,
    this.cart,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ManageAddressesBloc(
                addresssRepository: RepositoryProvider.of(context))
              ..add(LoadAllAddresses('id1'))),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SelectAddressContainer()),
              SelectAddressCartTotal(
                cart: cart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
