import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/api_repository.dart';
import '../../../bloc/main/dashboard/dashboard_bloc.dart';
import '../../../widgets/screen_type_widget.dart';
import 'dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        context: context,
        apiRepository: ApiRepository(context: context),
      ),
      child: ScreenTypeWidget(mobileView: DashboardBody()),
    );
  }
}
