import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class ManageAddressesScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const ManageAddressesScreenDesktop({Key key, this.scrollController})
      : super(key: key);

  @override
  _ManageAddressesScreenDesktopState createState() =>
      _ManageAddressesScreenDesktopState();
}

class _ManageAddressesScreenDesktopState
    extends State<ManageAddressesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonList(
                isManageAddressesSelected: true,
              ),
              Expanded(child: ManageAddressesContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
