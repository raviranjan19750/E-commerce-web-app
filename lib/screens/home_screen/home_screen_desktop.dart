import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/scroll/bloc/scroll_bloc.dart';
import 'package:living_desire/widgets/footer/footer.dart';
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
    return MyDesktopView(
      child: Container(
        child: Column(
          children: [
            // Products Category Body for HomeScreen
            ProductsHomeOverview(),
          ],
        ),
      ),
    );
  }
}

class MyDesktopView extends StatelessWidget {
  final Widget child;

  ScrollController _scrollController = ScrollController();

  MyDesktopView({Key key, this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScrollBloc(controller: _scrollController),
      child: Scaffold(
        appBar: CustomAppBar(
          size: 116,
          visibleMiddleAppBar: true,
        ),
        // backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              child,
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
