import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../repository/api_repository.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/validation_utils.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final BuildContext context;
  final ApiRepository apiRepository;
  SplashBloc({required this.context, required this.apiRepository})
      : super(SplashInitial()) {
    on<CheckAuthEvent>((event, emit) => _checkAuthStatus(emit: emit));
  }
}

extension on SplashBloc {
  _checkAuthStatus({required Emitter emit}) async {
    final userToken =
        PreferenceUtils.shared.getString(key: PreferenceKeys.authToken);
    if (isNullEmptyOrFalse(userToken)) {
      emit(const AuthSuccessState(isLoggedIn: false));
    } else {
      emit(const AuthSuccessState(isLoggedIn: true));
    }
  }
}
