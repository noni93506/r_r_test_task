import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:r_r_t_app/presentation/login_screens/login_screen.dart';
import 'package:r_r_t_app/repository/local_storage_repository.dart';
import 'package:r_r_t_app/repository/login_repository.dart';
import 'package:r_r_t_app/validators/email_validator.dart';
import 'package:r_r_t_app/validators/password_validator.dart';

class TestApp extends StatelessWidget {
  TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorageRepository>(
          create: (context) => LocalStorageRepository(),
        ),
        RepositoryProvider<EmailValidator>(
          create: (context) => EmailValidator(),
        ),
        RepositoryProvider<PasswordValidator>(
          create: (context) => PasswordValidator(),
        ),
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(),
        ),
      ],
      child: Builder(builder: (context) {
        return const MaterialApp(
          title: "Test App",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: LogInScreen(),
        );
      }),
    );
  }
}
