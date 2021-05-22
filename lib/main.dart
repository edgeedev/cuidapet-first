import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await loadEnv();

  runApp(ModularApp(module: AppModule()));
}

Future<void> loadEnv() async {
  const isProduction = bool.fromEnvironment('dart.vm.product');

  if (isProduction) {
    await DotEnv.load(fileName: '.env');
  } else {
    await DotEnv.load(fileName: '.env_dev');
  }
}
