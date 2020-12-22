import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class CartScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CartBloc(cartRepository: RepositoryProvider.of(context))
                  ..add(LoadAllCart('id1'))),
        BlocProvider(
          create: (context) => CartTotalBloc(
              cartRepository: RepositoryProvider.of(context)),
        ),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonList(
            isMyCartSelected: true,
          ),
          Expanded(child: CartContainer()),
        ],
      ),
    );
  }
}
