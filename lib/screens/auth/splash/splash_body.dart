// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth/splash/splash_bloc.dart';
import '../../../utils/bloc_utils.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/functions_utils.dart';
import '../../../utils/navigation_utils.dart';
import '../../../widgets/image_widget_util.dart';
import '../../../widgets/responsive_widget.dart';
import '../../main/dashboard/dashboard_screen.dart';
import '../sign_in/sign_in_screen.dart';

class SplashBody extends StatelessWidget {
  late BlocUtils blocUtils;
  late SplashBloc splashBloc;

  SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocUtils = BlocUtils(context: context);
    splashBloc = blocUtils.getSplashBloc();
    splashBloc.add(const CheckAuthEvent());

    return _blocView();
  }
}

extension on SplashBody {
//Bloc view
  Widget _blocView() {
    return BlocConsumer<SplashBloc, SplashState>(builder: ((context, state) {
      return _contentView();
    }), listener: (context, state) async {
      if (state is AuthSuccessState) {
        await Future.delayed(const Duration(seconds: 2));
        if (state.isLoggedIn) {
          NavigationUtils.getOffAll(const DashboardScreen());
        } else {
          NavigationUtils.getOffAll(const SignInScreen());
        }
      }
    });
  }

  //Content view
  Widget _contentView() {
    return ResponsiveWidget(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: getLinearGradient(isVerticalGradient: true),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: imgAssetWidget(
                    'app_icon.png',
                    color: ColorsUtils.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
