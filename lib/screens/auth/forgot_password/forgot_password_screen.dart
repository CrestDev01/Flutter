import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/forgot_password/forgot_password_bloc.dart';
import '../../../repository/api_repository.dart';
import '../../../widgets/screen_type_widget.dart';
import 'forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        context: context,
        apiRepository: ApiRepository(context: context),
      ),
      child: ScreenTypeWidget(mobileView: ForgotPasswordBody()),
    );
  }
}
