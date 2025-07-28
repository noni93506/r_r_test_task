import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:r_r_t_app/presentation/components/extensions/build_context_extensions.dart';
import 'package:r_r_t_app/presentation/components/loading/app_loading_overlay.dart';
import 'package:r_r_t_app/presentation/home_screen/home_bloc.dart';
import 'package:r_r_t_app/presentation/home_screen/home_state.dart';
import 'package:r_r_t_app/presentation/login_screens/login_screen.dart';
import 'package:r_r_t_app/repository/local_storage_repository.dart';
import 'package:r_r_t_app/resources/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => HomeBloc(
            localStorageRepository: context.read<LocalStorageRepository>(),
          ),
      child: Builder(
        builder: (context) {
          return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.isUserDone) {
                _openLogInScreen(context);
              }
              if (state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            child: buildScaffold(context),
          );
        },
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.homeScreenAppBapTitle,
          style: AppTextStyles.h1Bold,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text("${context.strings.homeScreenEmailTitle}${bloc.state.email}"),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                bloc.add(RemoveToken());
              },
              child: Text(context.strings.logOut, style: AppTextStyles.h2Bold),
            ),
          ],
        ),
      ),
    );
  }

  void _openLogInScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoaderOverlay(
            overlayWidgetBuilder: (context) {
              return const AppLoadingOverlay();
            },
            overlayWholeScreen: false,
            child: const LogInScreen(),
          );
        },
      ),
    );
  }
}
