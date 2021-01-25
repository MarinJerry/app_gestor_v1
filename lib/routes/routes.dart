import 'package:flutter/material.dart';

import 'package:app_gestor_v1/view/login.dart';
import 'package:app_gestor_v1/view/login_phone.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => AccessPage(),
    'phone': (BuildContext context) => AccessPhonePage(),
    // AvatarPage.pageName : ( BuildContext context ) => AvatarPage(),
    // 'card'   : ( BuildContext context ) => CardPage(),
    // 'animatedContainer'   : ( BuildContext context ) => AnimatedContainerPage(),
    // 'inputs' : ( BuildContext context ) => InputPage(),
    // 'slider' : ( BuildContext context ) => SliderPage(),
    // 'list'   : ( BuildContext context ) => ListaPage(),
  };
}
