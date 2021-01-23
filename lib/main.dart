import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/DBHandler/address_repository.dart';
import 'package:living_desire/DBHandler/footerRepository.dart';
import 'package:living_desire/DBHandler/promo_code_repository.dart';
import 'package:living_desire/bloc/analytics/analytics_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/home/home_bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/localwishlist.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/analytics_repo.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:living_desire/service/sharedPreferences.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import './config/configs.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import 'bloc/cart_config/cart_config_bloc.dart';
import 'bloc/wishlist_config/wishlist_bloc.dart';
import 'config/CustomRouteObserver.dart';

import 'dart:js' as js;

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

const wishlistBox = 'wishlist_items';
const cartlistBox = 'cart_items';
const customCartlistBox = 'custom_cart_items';

Future<void> main() async {
  Hive.registerAdapter<Product>(ProductAdapter());
  Hive.registerAdapter<NormalCartLocal>(NormalCartLocalAdapter());
  Hive.registerAdapter<CustomCartLocal>(CustomCartLocalAdapter());
  Hive.registerAdapter<WishlistLocal>(WishlistLocalAdapter());

  // await Hive.openBox<Map<String, String>>(wishlistBox);
  // await Hive.openBox<Map<String, String>>(cartlistBox);
  await Hive.openBox<NormalCartLocal>(cartlistBox);
  await Hive.openBox<CustomCartLocal>(customCartlistBox);
  await Hive.openBox<WishlistLocal>(wishlistBox);
  // await Hive.openBox<Product>(cartlistBox);
  final FirebaseApp _initialization = await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await UserPreferences().init();
  setupLocator();
  var authRepo = AuthenticationRepository();
  // await authRepo.signInAnony();

  await SentryFlutter.init(
    (options) => options.dsn =
        'https://ca6de53fe8f94dc98988539d7e5642cb@o508594.ingest.sentry.io/5601312',
    appRunner: () async {
      try {
        runApp(MyApp(
          authRepo: authRepo,
        ));
      } catch (exception, stackTrace) {
        await Sentry.captureException(exception, stackTrace: stackTrace);
      }
    },
  );
}

class InitailizeAppService extends StatelessWidget {
  final AuthenticationRepository authRepo;
  final Widget child;
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  const InitailizeAppService({Key key, this.authRepo, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AnalyticsRepository()),
        RepositoryProvider(
          create: (context) => authRepo,
        ),
        RepositoryProvider(
          create: (context) => SearchApi(),
        ),
        RepositoryProvider(
          create: (context) => AddressRepository(),
        ),
        RepositoryProvider(
          create: (context) => WishlistRepository(),
        ),
        RepositoryProvider(
          create: (context) => NormalOrderRepository(),
        ),
        RepositoryProvider(
          create: (context) => CartRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider(
          create: (context) => SelectAddressTypeRepository(),
        ),
        RepositoryProvider(
          create: (context) => PromoCodeRepository(),
        ),
        RepositoryProvider(
            create: (context) => CustomerDetailRepository(
                wishlistRepo: RepositoryProvider.of(context),
                cartRepository: RepositoryProvider.of(context))),
        RepositoryProvider(create: (context) => FooterRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AnalyticsBloc(
                  analyticsRepository: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) => WishlistConfigBloc(
                  customerRepository: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) => CartConfigBloc(
                  customerRepository: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) =>
                  SignInBloc(authService: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) =>
                  SearchBloc(searchApi: RepositoryProvider.of(context))),
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: RepositoryProvider.of(context),
                  cartConfigBloc: BlocProvider.of(context),
                  wishlistConfigBloc: BlocProvider.of(context))),
          BlocProvider(create: (context) => HomeBloc())
        ],
        child: child,
      ),
    );
  }
}

var LOG = Logger();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthenticationRepository authRepo;

  MyApp({Key key, this.authRepo}) : super(key: key);

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
        builder: (context, child) => child,
        navigatorKey: locator<NavigationService>().navigatorKey,
        navigatorObservers: [
          CustomRouteObserver(),
          AnalyticsRepository.observer
        ],
        onGenerateRoute: RoutesConfiguration.onGenerateRoute,
      ),
    );
  }
}
