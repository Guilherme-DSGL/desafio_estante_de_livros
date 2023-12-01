import 'package:flutter_modular/flutter_modular.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((context, args) => const HomePage())),
  ];
}
