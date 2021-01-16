import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/login/login_view.dart';
import '../../widgets/widgets.dart';

class SelectAddressScreenDesktop extends StatelessWidget {
  // 3 variables to check from wich screen user is coming from
  final String isBuyNow;
  final String isNormalCart;
  final String isBulkOrderCart;

  // data from buy now, bulk order, normal cart
  final String productID;
  final String variantID;
  final String totalItems;
  final String isSampleRequested;

  const SelectAddressScreenDesktop({
    Key key,
    this.productID = '',
    this.variantID = '',
    this.totalItems = '',
    this.isSampleRequested = "false",
    this.isBuyNow = "false",
    this.isNormalCart = "false",
    this.isBulkOrderCart = "false",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$isBuyNow, $isNormalCart, $isBulkOrderCart');
    void _showLoginDialog(BuildContext context) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoginScreen();
          });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectAddressCartTotal(),
      ],
    );

    // return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //     builder: (context, state) {
    //   switch (state.status) {
    //     case AuthenticationStatus.authenticated:
    //       return MultiBlocProvider(
    //         providers: [
    //           BlocProvider(
    //               create: (context) => ManageAddressesBloc(
    //                   addresssRepository: RepositoryProvider.of(context))
    //                 ..add(LoadAllAddresses(state.user.uid))),
    //           BlocProvider(create: (context) => SelectAddressBloc()),
    //         ],
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(
    //                 child: SelectAddressContainer(
    //               authID: state.user.uid,
    //             )),
    //             if (isBuyNow == "true")
    //               SelectAddressCartTotal(
    //                 type: SelectAddressStateType.BUY_NOW,
    //                 authID: state.user.uid,
    //                 productID: productID,
    //                 variantID: variantID,
    //               ),
    //             if (isNormalCart == "true")
    //               SelectAddressCartTotal(
    //                 type: SelectAddressStateType.NORMAL_CART,
    //                 authID: state.user.uid,
    //               ),
    //             if (isBulkOrderCart == "true")
    //               SelectAddressCartTotal(
    //                 type: SelectAddressStateType.BULK_ORDER,
    //                 authID: state.user.uid,
    //                 totalItems: totalItems,
    //                 isBulkOrderCartStr: isBulkOrderCart,
    //                 isSampleRequestedStr: isSampleRequested,
    //               ),
    //           ],
    //         ),
    //       );
    //     case AuthenticationStatus.unauthenticated:
    //       return Center(
    //         child: Container(
    //           padding: EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: Palette.secondaryColor,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           // Login Button
    //           child: InkWell(
    //             onTap: () {
    //               _showLoginDialog(context);
    //             },
    //             child: Text(
    //               Strings.loginText,
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       );
    //     default:
    //       return Container();
    //   }
    // });
  }
}
