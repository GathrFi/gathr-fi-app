import 'package:flutter/material.dart';

import 'src/gathrfi_app.dart';
import 'src/gathrfi_app_di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const GathrfiApp());
}
