//import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/core/services/config_service.dart';
import 'package:rapi_car_app/core/services/stripe_service.dart';
import 'package:rapi_car_app/di/locator.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/src/routes/routes.dart';
import 'package:rapi_car_app/ui/bloc/map/map_bloc.dart';
import 'package:rapi_car_app/ui/bloc/my_location/my_location_bloc.dart';
import 'package:rapi_car_app/ui/bloc/payment/payment_bloc.dart';
import 'package:rapi_car_app/ui/util/dialog/dialog_view.dart';
import 'package:rapi_car_app/ui/views/loading_view.dart';
import 'package:rapi_car_app/ui/views/home/home_view.dart';

import 'package:rapi_car_app/bloc/provider.dart' as bloc_provider;
import 'package:rapi_car_app/core/services/user_service.dart';
 
void main() async {
  await initMyApp();
  //await locator<EnvironmentService>().dev();
  runApp(bloc_provider.Provider(child: MyApp()));
  //MyApp();
}

void initMyApp() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    //Fimber.plantTree(DebugTree.elapsed(useColors: true));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    await setupLocator();
    //await Firebase.initializeApp();

    //final prefs = PreferenciasUsuario();
    //await prefs.initPrefs();

    //await locator<UserService>().getLocalUser();
    //await locator<AccountService>().getLocalAccount();
  } catch (e) {
    print('No se ha podido iniciar el localizador de servicios');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(R.image.no_image_jpg(), context);
    StripeService()..init();
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    return MultiProvider(
      providers: [
        /*StreamProvider(
          initialData: locator<UserService>().user,
          create: (BuildContext context) => locator<UserService>().userStream,
        ),*/
        BlocProvider(create: (_) => MyLocationBloc()),
        BlocProvider(create: (_) => MapBloc()),
        BlocProvider(create: (_) => PaymentBloc()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CarService()),
        ChangeNotifierProvider(create: (_) => ConfigService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        /*localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', ''), // English, no country code
          const Locale('en', ''), // English, no country code
        ],*/
        title: 'RapiCar',
        /*builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) {
              return DialogView(child: widget);
            },
          ),
        ),*/
        initialRoute: LoadingView.id,
        onGenerateRoute: generateRoutes,
        /*theme: ThemeData.light().copyWith(
          //primaryColor: kPrimaryColor,
          //accentColor: kAccentColor,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            elevation: 0.0,
            centerTitle: true,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
                //fontFamily: R.fontFamily.avenirNextLTPro,
              ),
        ),*/
      ),
    );
  }
  /*Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: getApplicationRoutes(),
    );
  }*/
}