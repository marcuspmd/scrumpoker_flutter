import 'package:flutter_modular/flutter_modular.dart';
import 'package:scrumpoker_flutter/atoms/core_reduce.dart';
import 'package:scrumpoker_flutter/modules/core/adapters/cache_impl.dart';
import 'package:scrumpoker_flutter/modules/core/presenter/pages/home_page.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  final SharedPreferences prefs;

  AppModule({
    required this.prefs,
  });

  @override
  void binds(i) {
    i.addInstance(prefs);
    i.addLazySingleton<Cache>(CacheImpl.new);
    i.addSingleton(CoreReduce.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const HomePage(),
    );
  }
}
