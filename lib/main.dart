import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/account/bloc/account_bloc.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/locator.dart';
import 'package:i2hand/src/router/router.dart';
import 'package:i2hand/src/theme/themes.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final appRouter = GetIt.I<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountBloc()),
      ],
      child: MediaQuery(
        data: data.copyWith(textScaler: TextScaler.noScaling),
        child: MaterialApp.router(
          title: "i2hand",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) => S.of(context).i2hand,
          builder: BotToastInit(),
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          routerConfig: appRouter.router,
        ),
      ),
    );
  }
}
