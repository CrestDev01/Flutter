import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth/sign_in/sign_in_bloc.dart';
import '../../../repository/api_repository.dart';
import '../../../widgets/screen_type_widget.dart';
import 'sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  final bool showBackArrow;

  const SignInScreen({Key? key, this.showBackArrow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(
            context: context,
            apiRepository: ApiRepository(context: context),
          ),
        ),
        /*BlocProvider<SocialSignInBloc>(
          create: (BuildContext context) => SocialSignInBloc(
            context: context,
            apiRepository: ApiRepository(context: context),
          ),
        ),*/
      ],
      child: ScreenTypeWidget(
          mobileView: SignInBody(showBackArrow: showBackArrow)),
    );
  }
}
