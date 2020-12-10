import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/DBHandler/address_repository.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/screens/screens.dart';
import 'package:living_desire/screens/select_address_screen/select_address_screen.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/searchapi.dart';
import './config/configs.dart';
import 'bloc/all_product/all_product_bloc.dart';
import 'bloc/filter/filter_bloc.dart';

void main() async {
  final FirebaseApp _initialization = await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class InitailizeAppService extends StatelessWidget {
  final Widget child;

  const InitailizeAppService({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (context) => SearchApi(),
        ),
        RepositoryProvider(
          create: (context) => AddresssRepository(),
        ),
        RepositoryProvider(
          create: (context) => WishlistRepository(),
        ),
        RepositoryProvider(
          create: (context) => NormalOrderRepository(),
        ),
        RepositoryProvider(
          create: (context) => CartRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  SignInBloc(authService: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) =>
                  SearchBloc(searchApi: RepositoryProvider.of(context))),
        ],
        child: child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return InitailizeAppService(
      child: MaterialApp(
        title: Strings.websiteName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: ManageAddressesScreen(),
        onGenerateRoute: RoutesConfiguration.onGenerateRoute,
      ),
    );
  }
}
