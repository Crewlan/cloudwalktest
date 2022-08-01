import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/navigation/router.dart';
import 'core/navigation/routes.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  await di.init();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initializeDateFormatting('pt_BR', null);
    return MaterialApp(
      title: AppStrings.appTitle,
      themeMode: ThemeMode.dark,
      onGenerateRoute: _router.generateRoutes,
      initialRoute: Routes.home,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.lightest),
      navigatorObservers: [HeroController()],
    );
  }
}
