import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/searchapi.dart';
import './config/configs.dart';

void main() async {
  final FirebaseApp _initialization = await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  var authRepo = AuthenticationRepository();
  // await authRepo.signInAnony();
  runApp(MyApp(
    authRepo: authRepo,
  ));
}

class InitailizeAppService extends StatelessWidget {
  final AuthenticationRepository authRepo;
  final Widget child;

  const InitailizeAppService({Key key, this.authRepo, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => authRepo,
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
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: RepositoryProvider.of(context)))
        ],
        child: child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthenticationRepository authRepo;

  const MyApp({Key key, this.authRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitailizeAppService(
      authRepo: authRepo,
      child: MaterialApp(
        title: Strings.websiteName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        onGenerateRoute: RoutesConfiguration.onGenerateRoute,
      ),
    );
  }
}
