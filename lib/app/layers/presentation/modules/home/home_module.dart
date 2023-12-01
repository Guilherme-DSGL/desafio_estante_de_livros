import 'package:desafio_estante_de_livros/app/layers/presentation/modules/home/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((context, args) => const HomePage())),
  ];
}
