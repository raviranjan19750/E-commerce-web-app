import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import '../widgets.dart';

class NormalOrdersContainer extends StatelessWidget {
  // Normal Order Container
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NormalOrderBloc, NormalOrderState>(
      builder: (context, state) {
        if (state is NormalOrderDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is NormalOrderDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  ...state.order.map(
                    (orderItem) => OrderItem(
                      order: orderItem,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
