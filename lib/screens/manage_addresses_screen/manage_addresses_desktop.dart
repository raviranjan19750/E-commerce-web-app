import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ManageAddressesBloc(
                addresssRepository: RepositoryProvider.of(context))
              ..add(LoadAllAddresses('id1'))),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
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
