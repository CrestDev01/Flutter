import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../bloc/auth/forgot_password/forgot_password_bloc.dart';
import '../bloc/auth/sign_in/sign_in_bloc.dart';
import '../bloc/auth/splash/splash_bloc.dart';
import '../bloc/main/dashboard/dashboard_bloc.dart';

class BlocUtils {
  BuildContext? context;

  BlocUtils._({this.context});

  static DashboardBloc? dashboardBloc;

  factory BlocUtils({required BuildContext? context}) {
    return BlocUtils._(context: context);
  }

  SplashBloc getSplashBloc() {
    return Provider.of<SplashBloc>(context!, listen: false);
  }

  SignInBloc getSignInBloc() {
    return Provider.of<SignInBloc>(context!, listen: false);
  }

  ForgotPasswordBloc getForgotPasswordBloc() {
    return Provider.of<ForgotPasswordBloc>(context!, listen: false);
  }


  DashboardBloc? getDashboardBloc({bool clearBloc = false}) {
    if (clearBloc) {
      dashboardBloc = null;
    } else {
      dashboardBloc ??= Provider.of<DashboardBloc>(context!, listen: false);
    }

    return dashboardBloc;
  }
}
