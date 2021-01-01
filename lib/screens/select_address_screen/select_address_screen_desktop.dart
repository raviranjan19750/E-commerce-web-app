import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/service/sharedPreferences.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class SelectAddressScreenDesktop extends StatelessWidget {

  final List<Cart> cart;

  String authID = UserPreferences().AuthID;

  bool isCustomOrder,isSampleRequested;

  int totalItems;

  SelectAddressScreenDesktop({
    Key key,
    this.cart,
    this.isCustomOrder,
    this.isSampleRequested,
    this.totalItems
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
          ),
        ],
      ),
    );
  }
}
