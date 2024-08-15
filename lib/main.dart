import 'package:booktaste/binding/general_bindings.dart';
import 'package:booktaste/common/features/on_boarding/onboarding_pages.dart';
import 'package:booktaste/routes/user_admin_routes/user_routes.dart';
import 'package:booktaste/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_routes/app_routes.dart';

Future<void> main() async {
  ///Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  ///Getx local strorage
  await GetStorage.init();
  // await initServices();

  ///await splash until other items load
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  ///laod all the material design/ themes/ localizaations/ binding
  runApp(const MyApp());
}

// Future<void> initServices() async {
//   Get.put(AuthService());
//   final AuthService _authService = Get.find<AuthService>();

//   print(_authService.currentUser.toString());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      ///Get Bindings
      initialBinding: GeneralBindings(),

      ///!Routes
      getPages: AppRoutes.pages,

      ///! initial Route:
      // initialRoute: AdminRoutes.navigation,
      // initialRoute: UserRoutes.navigation,
      initialRoute: UserAdminRoues.login,
      // initialRoute: UserAdminRoues.onBoarding,

      ///Other
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      //home
    );
  }
}
