import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomeScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

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
        child: Container(
          child: Column(
            children: [
              SubAppBar(),
              // Products Category Body for HomeScreen
              ProductsHomeOverview(),
            ],
          ),
        ),
      ),
    );
  }
}
