import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:camera/camera.dart';

import 'global.dart';
import 'app.dart';

/// setup
Future<void> setup() async {

  // Ensure that plugin services are initialized so that availableCameras() can be called before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  // logging
  // https://pub.dev/packages/logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });  

  final setupLogger = Logger('Setup');

  // see if we can get the available camera for the current device
  try {
    availableDeviceCameras = await availableCameras();
  } on CameraException catch (error, stack) {
    setupLogger.severe('message', error, stack);
  }

  setupLogger.fine('setup complete!');
}

/// entry point
Future<void> main() async {
  await setup();
  runApp(InvestigationApp());
}