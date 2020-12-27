import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/home/home_bloc.dart';
import 'package:living_desire/bloc/scroll/bloc/scroll_bloc.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/screens/screens.dart';
import 'package:living_desire/widgets/footer/footer.dart';
import 'package:living_desire/widgets/home_widget/home_widget.dart';
import 'package:living_desire/widgets/labeltag/label_tag.dart';
import 'package:living_desire/widgets/nextListHover.dart';
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
        padding: EdgeInsets.only(left: 75, right: 75),
        child: Column(
          children: [
            // Products Category Body for HomeScreen
            // ProductsHomeOverview(),
            HomeScreenvView()
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
              SizedBox(
                height: 20,
              ),
              child,
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenvView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is SuccessfulLoadingHomeProducts) {
          print("OK ");
          List<HomeWidget> widgetList = [];
          state.productList.forEach((key, value) {
            widgetList.add(HomeWidget(
              labeltxt: key,
              productlist: value,
            ));
          });
          return Column(
            children: widgetList,
          );
          // return HomeWidget(
          //   labeltxt: 'Bean Bags',
          //   productlist: state.productList['Bean Bags'],
          // );
          // return Container(
          //   height: 140,
          //   width: 140,
          //   color: Colors.green,
          //   child: Text("Houston eagle has landed ......."),
          // );
        } else if (state is HomeInitial) {
          print("initialising home.... ");
          BlocProvider.of<HomeBloc>(context).add(InitializeHome());
          return Container(
            height: 140,
            width: 140,
            color: Colors.blue,
            child: Text("DEVAHISH"),
          );
        } else {
          return Container(
            height: 140,
            width: 140,
            color: Colors.green,
            child: Text("DEVASHISH"),
          );
        }
        // return ListView.builder(itemBuilder:

        // );
      },
    );
  }
}
