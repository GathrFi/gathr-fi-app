import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'gathrfi_app_di.config.dart';

final locator = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() => locator.init();
