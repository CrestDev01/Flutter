import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:boilerplate/utils/colors_utils.dart';
import 'package:tuple/tuple.dart';

import '../../../model/global/bottom_bar_items_model.dart';
import '../../../model/global/error_model.dart';
import '../../../model/global/success_model.dart';
import '../../../repository/api_repository.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/helper_utils.dart';
import '../../../utils/permissions_utils.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final BuildContext context;
  final ApiRepository apiRepository;

  List<BottomBarItemsModel> bottomBarItems = [];
  List<Widget> bottomBarPagesList = [];

  int initialIndex = 0;

  bool changeTab = false;

  DashboardBloc({required this.context, required this.apiRepository})
      : super(DashboardInitial()) {
    on<ChangeTabEvent>((event, emit) => _changeTab(event: event, emit: emit));
    on<LogoutEvent>((event, emit) => _logout(event: event, emit: emit));

    on<LoadingEvent>((event, emit) => _onLoading(emit: emit));
  }
}

extension BottomBarExt on DashboardBloc {
  //Load bottom bar data
  void loadBottomBarData() {
    bottomBarItems.clear();
    bottomBarPagesList.clear();

    bottomBarItems
      ..add(BottomBarItemsModel(
        itemName: "Dashboard",
        icon: 'ic_dashboard.png',
        selectedIcon: 'ic_dashboard.png',
      ))
      ..add(BottomBarItemsModel(
        itemName: "Calendar",
        icon: 'ic_calendar.png',
        selectedIcon: 'ic_calendar.png',
      ))
      ..add(BottomBarItemsModel(
        itemName: "Profile",
        icon: 'ic_client.png',
        selectedIcon: 'ic_client.png',
      ));

    bottomBarPagesList.add(Container());
    bottomBarPagesList.add(Container());
    bottomBarPagesList.add(Container());
    // bottomBarPagesList.add(SafetyBuddyScreen());
    // bottomBarPagesList.add(IncidentReportsScreen());
  }
}

extension CommonExt on DashboardBloc {
  //Change tab
  void _changeTab({required ChangeTabEvent event, required Emitter emit}) {
    emit(ChangeTabState(
      index: event.index,
    ));
  }

  //Show loader
  void _onLoading({required Emitter emit}) {
    emit(LoadingState());
  }
}

extension on DashboardBloc {
  //Logout
  void _logout({required LogoutEvent event, required Emitter emit}) async {
    add(const LoadingEvent());

    String? deviceId = await HelperUtils.getDeviceId();

    Tuple3<SuccessModel?, ErrorModel?, bool>? tuple =
        await apiRepository.logout(
      deviceId: deviceId!,
    );

    if (tuple != null) {
      if (tuple.item3) {
        emit(LogoutSuccessState(successModel: tuple.item1));
      } else {
        emit(LogoutErrorState(errorModel: tuple.item2));
      }
    }
  } //Logout
}
