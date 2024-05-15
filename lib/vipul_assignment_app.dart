import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vipul_test_assignment/blocs/countries_bloc/countries_bloc.dart';
import 'package:vipul_test_assignment/presentation/widgets/loading_spinner.dart';
import 'package:vipul_test_assignment/services/route_service.dart';
import 'package:vipul_test_assignment/wrappers/dismiss_keyboard.dart';

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
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(),
              child: LoadingSpinner(
                opacity: 0.25,
                child: child,
              ),
            );
          },

        ),
      ),
    );
  }
}
