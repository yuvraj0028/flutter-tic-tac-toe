import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '/screen/home_page.dart';
import '/widget/scroll.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: List.empty(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final androidVersion =
      deviceInfo is AndroidDeviceInfo ? deviceInfo.version.sdkInt : 0;

  runApp(
    MyApp(
      androidSDKVersion: androidVersion,
    ),
  );
}

class MyApp extends StatefulWidget {
  final int androidSDKVersion;

  const MyApp({super.key, required this.androidSDKVersion});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.indigo[400],
        secondary: Colors.red[200],
        error: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            titleMedium: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleSmall: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
    );

    final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.indigo[400],
        secondary: Colors.red[200],
        error: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            titleMedium: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleSmall: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).textScaleFactor * 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: Scroll(androidSDKVersion: widget.androidSDKVersion),
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    );
  }
}
