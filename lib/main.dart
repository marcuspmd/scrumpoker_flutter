import 'package:asp/asp.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: '.env');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  setPathUrlStrategy();
  runApp(ModularApp(
    module: AppModule(
      prefs: prefs,
    ),
    child: const RxRoot(
      child: MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => darkMode.value);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: darkMode.value ? ThemeData.dark() : ThemeData.light(),
      title: 'Scrum Poker',
      routerConfig: Modular.routerConfig,
      builder: Asuka.builder,
    );
  }
}
