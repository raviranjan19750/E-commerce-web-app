import 'package:flutter/material.dart';
import 'package:living_desire/screens/all_product/all_product_screen.dart';
import '../../widgets/widgets.dart';

class HomeScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  _HomeScreenDesktopState createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    //TODO: Can Change the App Bar to sliver app bar,
    //But may need to change app bar properties later
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: AllProductScreen(),
        // child: Container(
        //   child: Column(
        //     children: [
        //       // Products Category Body for HomeScreen
        //       ProductsHomeOverview(),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
