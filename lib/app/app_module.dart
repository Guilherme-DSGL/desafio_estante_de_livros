import 'package:flutter_modular/flutter_modular.dart';

import 'layers/presentation/modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [HomeModule()];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];
}
