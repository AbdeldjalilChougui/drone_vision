import 'package:flutter/material.dart';

import 'package:workmanager/workmanager.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/app/app.router.dart';
import 'package:drone_vision/ui/setup_dialogui.dart';
import 'package:stacked_services/stacked_services.dart';
import 'foreground_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  setupLocator();
  setupDialogUi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZwedJ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins",),
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.splashView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}