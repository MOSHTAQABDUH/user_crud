import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user_crud/app/routes/routes/app_routes.dart';
import 'app/routes/routes/app_page.dart';
import 'app/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("pt", "BR"),
    ],
    title: 'CRUD Usuários',
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.LOGIN,
    theme: appThemeData,
  ));
}
