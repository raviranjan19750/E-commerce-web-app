import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:living_desire/screens/bulk_order/bulk_order.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation.dart';
import 'package:living_desire/screens/my_orders/my_bulk_order.dart';
import 'package:living_desire/screens/my_orders/my_order.dart';
import './config/configs.dart';
import 'screens/login/login.dart';

void main() async {
  final FirebaseApp _initialization = await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.websiteName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthenticationRepository(),
          ),
          RepositoryProvider(
            create: (context) => SearchApi(),
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
          child: MyOrder(),
        ),
      ),
    );
  }
}
