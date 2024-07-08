import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../model/global/error_model.dart';
import '../../../model/global/success_model.dart';
import '../../../repository/api_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final BuildContext context;
  final ApiRepository apiRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerOtpCode = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  bool isEmailVerified = false;
  bool isPasswordVisible = false;

  ForgotPasswordBloc({required this.context, required this.apiRepository})
      : super(ForgotPasswordInitial()) {
    on<ValidateFormEvent>(
        (event, emit) => _onValidateForm(event: event, emit: emit));
    on<ChangePasswordVisibilityEvent>(
        (event, emit) => _changePasswordVisibility(event: event, emit: emit));
    on<LoadingEvent>((event, emit) => _onLoading(emit: emit));
    on<ForgotPasswordUserEvent>(
        (event, emit) => _forgotPassword(event: event, emit: emit));
    on<VerifyNewPasswordEvent>(
        (event, emit) => _verifyOtp(event: event, emit: emit));
  }
}

extension APIExt on ForgotPasswordBloc {
  //Update password visibility state
  void _changePasswordVisibility(
      {required ChangePasswordVisibilityEvent event, required Emitter emit}) {
    emit(ChangePasswordVisibilityState(value: event.value));
  }

  //Validate form
  void _onValidateForm(
      {required ValidateFormEvent event, required Emitter emit}) {
    emit(ValidateFormState(
        errorEmail: event.errorEmail, errorEmailMsg: event.errorEmailMsg));
  }

  //Forgot Password
  void _forgotPassword(
      {required ForgotPasswordUserEvent event, required Emitter emit}) async {
    add(const LoadingEvent());

    Tuple3<SuccessModel?, ErrorModel?, bool>? tuple =
        await apiRepository.forgotPassword(
      email: controllerEmail.text,
    );
    if (tuple != null) {
      if (tuple.item3) {
        emit(ForgotPasswordSuccessState(successModel: tuple.item1));
      } else {
        emit(ForgotPasswordErrorState(errorModel: tuple.item2));
      }
    } else {
      emit(ForgotPasswordErrorState(errorModel: tuple!.item2));
    }
  }

  //Verify Otp
  void _verifyOtp(
      {required VerifyNewPasswordEvent event, required Emitter emit}) async {
    add(const LoadingEvent());

    Tuple3<SuccessModel?, ErrorModel?, bool>? tuple =
        await apiRepository.verifyOtp(
      email: controllerEmail.text,
      otp: controllerOtpCode.text,
      password: controllerPassword.text,
    );
    if (tuple != null) {
      if (tuple.item3) {
        emit(VerifyNewPasswordSuccessState(successModel: tuple.item1));
      } else {
        emit(VerifyNewPasswordErrorState(errorModel: tuple.item2));
      }
    } else {
      emit(VerifyNewPasswordErrorState(errorModel: tuple!.item2));
    }
  }
}

extension LoaderExt on ForgotPasswordBloc {
  //Show loader
  void _onLoading({required Emitter emit}) {
    emit(const LoadingState());
  }
}
