import 'package:calculator/logic/bloc/calculation_history_bloc/bloc/calculation_history_bloc.dart';
import 'package:calculator/logic/bloc/calculator_bloc/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/themes/app_theme.dart';
import 'data/data_providers/local_data_provider/calculation_history_data.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive local storage
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  await CalculationHistoryDataProvider().initDataBase();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalculatorBloc()),
        BlocProvider<CalculationHistoryBloc>(
            create: (context) => CalculationHistoryBloc(
                historyDataProvider: CalculationHistoryDataProvider())
              ..add(const CalculationHistoryEventLoadHistorys())),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
