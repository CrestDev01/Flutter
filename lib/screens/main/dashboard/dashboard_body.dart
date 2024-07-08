import 'package:boilerplate/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base_classes/base_text.dart';
import '../../../bloc/main/dashboard/dashboard_bloc.dart';
import '../../../utils/bloc_utils.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/custom_dialog_utils.dart';
import '../../../utils/dimensions_utils.dart';
import '../../../utils/enum_utils.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/functions_utils.dart';
import '../../../utils/navigation_utils.dart';
import '../../../utils/preference_utils.dart';
import '../../../widgets/bottom_navbar_widget.dart';
import '../../../widgets/image_widget_util.dart';
import '../../auth/sign_in/sign_in_screen.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  late BlocUtils blocUtils;

  late DashboardBloc dashboardBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocUtils = BlocUtils(context: context);
    dashboardBloc = blocUtils.getDashboardBloc()!;

    dashboardBloc.loadBottomBarData();

    return _blocView();
  }

  @override
  void dispose() {
    super.dispose();

    blocUtils.getDashboardBloc(clearBloc: true);
  }
}

extension on _DashboardBodyState {
  //Bloc view
  Widget _blocView() {
    return BlocConsumer<DashboardBloc, DashboardState>(
        builder: ((context, state) {
      return _contentView();
    }), listener: (context, state) {
      //Change Tab
      if (state is ChangeTabState) {
        dashboardBloc
          ..initialIndex = state.index
          ..changeTab = true;
      } else if (state is LogoutSuccessState) {
        hideCustomDialog();
        PreferenceUtils.shared.removeKey(key: PreferenceKeys.userData);
        PreferenceUtils.shared.removeKey(key: PreferenceKeys.isLogin);
        PreferenceUtils.shared.removeKey(key: PreferenceKeys.authToken);
        NavigationUtils.getOffAll(const SignInScreen(showBackArrow: false));
      }
      //Logout error
      else if (state is LogoutErrorState) {
        hideCustomDialog();

        showToastMessage(dashboardBloc.context,
            message: state.errorModel!.message!.returnString(),
            status: MessageStatusEnum.error);
      }
    });
  }

  //Content view
  Widget _contentView() {
    return Scaffold(
      key: ScaffoldUtils.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsUtils.colorBase,
        title: BaseText(
          text: getPageTitleBasedOnIndex(dashboardBloc.initialIndex),
          myFont: MyFont.semiBold,
          color: ColorsUtils.colorWhite,
          fontSize: dim18,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ).copyWith(right: 8),
            child: InkWell(
              onTap: () {
                _logOutPopUp();
              },
              child: Icon(
                Icons.logout,
                color: ColorsUtils.colorWhite,
              ),
            ),
          ),
        ],
      ),
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           dashboardBloc.onStart();
      //         },
      //         icon: Icon(Icons.add)),
      //     IconButton(
      //         onPressed: () {
      //           dashboardBloc.onStop();
      //         },
      //         icon: Icon(Icons.remove)),
      //   ],
      // ),
      body: BottomNavbarWidget(
        bottomBarItems: dashboardBloc.bottomBarItems,
        pageViewsList: dashboardBloc.bottomBarPagesList,
        key: Key('${dashboardBloc.initialIndex}'),
        onTabChange: (index) {
          // if (index == 3) {
          //   dashboardBloc.scaffoldKey.currentState!.openEndDrawer();
          // }
          dashboardBloc.add(ChangeTabEvent(index: index));
        },
        initialIndex: dashboardBloc.initialIndex,
        changeTab: dashboardBloc.changeTab,
      ),
    );
  }

  String getPageTitleBasedOnIndex(int index) {
    return dashboardBloc.bottomBarItems[index].itemName.toString();
  }
}

extension on _DashboardBodyState {
  _logOutPopUp() {
    showPopUpDialog(
        text: "Confirm Logout",
        description: "Are you sure you want to logout?",
        textBtn1: "Cancel",
        textBtn2: "Logout",
        isSingleBtn: false,
        onTapBtn1: () {},
        onTapBtn2: () {
          dashboardBloc.add(LogoutEvent());
          // _myProfileBloc?.apiRepository.userLogoutEvent();
        });
  }
}
