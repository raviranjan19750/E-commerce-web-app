import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class SelectAddressScreenDesktop extends StatelessWidget {
  final List<Cart> cart;
  var authID = 'id1';

  SelectAddressScreenDesktop({
    Key key,
    this.cart,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ManageAddressesBloc(
                addresssRepository: RepositoryProvider.of(context))
              ..add(LoadAllAddresses(authID))),
      ],
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
    );
  }
}
