import 'package:bloc/bloc.dart';
import 'package:boilerplate/utils/validation_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import '../../../model/auth/login_model.dart';
import '../../../model/auth/login_model.dart';
import '../../../model/auth/login_model.dart';
import '../../../model/auth/login_model.dart';
import '../../../model/auth/login_model.dart';
import '../../../model/global/error_model.dart';
import '../../../repository/api_repository.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/custom_dialog_utils.dart';
import '../../../utils/enum_utils.dart';
import '../../../utils/functions_utils.dart';
import '../../../utils/navigation_utils.dart';
import '../../../utils/preference_utils.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final BuildContext context;
  final ApiRepository apiRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isRemember = false;
  int selectedTabIndex = 0;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  SignInBloc({required this.context, required this.apiRepository})
      : super(SignInInitial()) {
    on<ChangePasswordVisibilityEvent>(
        (event, emit) => _changePasswordVisibility(event: event, emit: emit));
    on<SignInUserEvent>((event, emit) => _signInUser(event: event, emit: emit));
    on<LoadingEvent>((event, emit) => _onLoading(emit: emit));
  }
}

extension on SignInBloc {
  //Update password visibility state
  void _changePasswordVisibility(
      {required ChangePasswordVisibilityEvent event, required Emitter emit}) {
    emit(ChangePasswordVisibilityState(value: event.value));
  }
}

extension APIExt on SignInBloc {
  //Sign in user
  void _signInUser(
      {required SignInUserEvent event, required Emitter emit}) async {
    add(LoadingEvent());

    Tuple3<LoginSuccessModel?, ErrorModel?, bool>? tuple =
        await apiRepository.userSignIn(bodyData: event.bodyData);
    if (tuple != null) {
      if (tuple.item3) {
        emit(SignInSuccessState(loginSuccessModel: tuple.item1));
      } else {
        emit(SignInErrorState(errorModel: tuple.item2));
      }
    }
  }

  //On sign in success
  void onSignInSuccess(
      {required LoginSuccessModel userModel, required BuildContext context}) {
    hideCustomDialog();

    // showToastMessage(apiRepository.context!,
    //     message: LocaleKeys.success_login.tr());

    PreferenceUtils.shared.setBoolean(key: PreferenceKeys.isLogin, value: true);
    saveUserData(userModel: userModel.data!.user!);

    PreferenceUtils.shared.setString(
        key: PreferenceKeys.authToken,
        value: userModel.data!.accessToken ?? "");
    // NavigationUtils.getOffAll(DashboardScreen());
  }

  //On sign in error
  void onSignInError({required ErrorModel errorModel}) {
    hideCustomDialog();

    showToastMessage(apiRepository.context!,
        message: errorModel.message!.returnString(),
        title: "SignIn Failed",
        status: MessageStatusEnum.error);
  }
}

extension LoaderExt on SignInBloc {
  //Show loader
  void _onLoading({required Emitter emit}) {
    emit(const LoadingState());
  }
}

extension SocialSignInExt on SignInBloc {}
