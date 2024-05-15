import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vipul_test_assignment/blocs/countries_bloc/countries_bloc.dart';
import 'package:vipul_test_assignment/presentation/widgets/loading_spinner.dart';
import 'package:vipul_test_assignment/services/route_service.dart';
import 'package:vipul_test_assignment/wrappers/dismiss_keyboard.dart';

import 'commons/helpers/theme_helper.dart';
import 'commons/theme/app_theme.dart';

final themeHelper = ThemeHelper();
bool isDarkMode = false;

class VipulAssignmentApp extends StatelessWidget {
  const VipulAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return DismissKeyboardWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            CountriesBloc countriesBloc = CountriesBloc();
            return countriesBloc..add(LoadCountries());
          })
        ],
        child: StreamBuilder<ThemeMode>(
            stream: themeHelper.themeStream,
            initialData: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            builder: (context, snapshot) {
              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: AppThemeManager.primaryBGColor,
                  primarySwatch: AppThemeManager.appPrimaryColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  brightness: Brightness.light,
                  useMaterial3: false,
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: AppThemeManager.primaryBGColor,
                  primarySwatch: AppThemeManager.appPrimaryColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  brightness: Brightness.dark,
                  useMaterial3: false,
                ),
                themeMode: snapshot.data,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(),
                    child: LoadingSpinner(
                      opacity: 0.25,
                      child: child,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
