import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_shared_app/src/app.dart';
import 'package:qr_shared_app/src/core/injector.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedDestinationHiveModelAdapter());
  await Hive.openBox<SavedDestinationHiveModel>('saved_destinations');
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  configureDependencies();
  runApp(const App());
}
