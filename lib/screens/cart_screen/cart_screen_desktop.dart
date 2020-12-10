import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class CartScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const CartScreenDesktop({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  _CartScreenDesktopState createState() => _CartScreenDesktopState();
}

class _CartScreenDesktopState extends State<CartScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CartBloc(cartRepository: RepositoryProvider.of(context))
                  ..add(LoadAllCart('id1'))),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
