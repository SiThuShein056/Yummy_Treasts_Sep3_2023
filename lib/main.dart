import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/admin_role/product/product_img_provider.dart';
import 'package:magical_food/pages/admin_role/special_list/sp_image_provider.dart';
import 'package:magical_food/pages/order_store/customer/order_provider/orde0r_noti_provider.dart';
import 'package:magical_food/pages/profile_screen/image_controller.dart';
import 'package:magical_food/util/address_provider.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/order_store/customer/provider/order_provider.dart';
import 'pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/langs', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
      saveLocale: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => ImageControllerProvider()),
        ChangeNotifierProvider(create: (context) => SPImageProvider()),
        ChangeNotifierProvider(create: (context) => ProductImageProvider()),
        ChangeNotifierProvider(create: (context) => OrderNotiProvider()),
      ],
      child: PreApp(),
    );
  }
}

class PreApp extends StatefulWidget {
  const PreApp({super.key});

  @override
  State<PreApp> createState() => _PreAppState();
}

class _PreAppState extends State<PreApp> {
  @override
  @override
  Widget build(BuildContext context) {
    ThemeProvider tmp = Provider.of(context, listen: false);
    tmp.checkThemeData();
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider tp, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: "Pyidaungsu",
          brightness: Brightness.light,
          primarySwatch: Colors.lightGreen,
          primaryColor: Color.fromARGB(255, 65, 145, 41),
          appBarTheme: AppBarTheme(color: Colors.green),
        ),
        darkTheme: ThemeData(
          fontFamily: "Pyidaungsu",
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          iconTheme: IconThemeData(
              // color: Color.fromARGB(255, 85, 3, 77),
              ),
          primaryColor: Color.fromARGB(255, 194, 192, 89),
          appBarTheme: AppBarTheme(color: Color.fromARGB(255, 194, 192, 89)),
        ),
        themeMode: tp.tm,
        home: SplashScreen(),
      );
    });
  }
}
