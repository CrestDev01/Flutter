import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate/screens/auth/splash/splash_body.dart';

import '../../../bloc/auth/splash/splash_bloc.dart';
import '../../../repository/api_repository.dart';
import '../../../widgets/screen_type_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        context: context,
        apiRepository: ApiRepository(context: context),
      ),
      child: ScreenTypeWidget(mobileView: SplashBody()),
    );
  }
}
