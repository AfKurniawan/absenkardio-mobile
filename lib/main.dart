import 'package:absensi_prodi/routes.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/main/providers/main_provider.dart';
import 'package:absensi_prodi/src/register/provider/register_provider.dart';
import 'package:absensi_prodi/src/splash/providers/splash_provider.dart';
import 'package:absensi_prodi/src/styles/theme.dart';
import 'package:absensi_prodi/src/styles/theme_provider.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //final prefs = await SharedPreferences.getInstance();
  //final isLogin = prefs.getBool("isLogin");
}

class MyApp extends StatelessWidget{
  static final navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //SharedPreferences.setMockInitialValues({});

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SplashProvider()),
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: RegisterProvider()),
        ChangeNotifierProvider.value(value: MainProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routing.getRoute(),
        initialRoute: "/",
        onGenerateRoute: (settings) => Routing.onGenerateRoute(settings),
        theme: MyTheme.lightTheme,
        navigatorKey: navKey,

        supportedLocales: [
          Locale('en', 'US'),
          Locale('id', 'ID')
        ],

        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }



}