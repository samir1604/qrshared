import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_shared_app/src/core/constants/string_constants.dart';
import 'package:qr_shared_app/src/core/services/services.dart';

import 'package:qr_shared_app/src/features/home/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appTitle,
      scaffoldMessengerKey: SnackbarService.messengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade900,
          primary: Colors.blue.shade900,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: mediaQueryData.textScaler.clamp(
              minScaleFactor: 1,
              maxScaleFactor: 1.3,
            ),
          ),
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}
