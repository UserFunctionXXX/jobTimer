import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/login/login_page.dart';
import 'package:job_timer/app/modules/splash/splash_page.dart';

class LoginModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => const LoginPage())),
      ];
}
