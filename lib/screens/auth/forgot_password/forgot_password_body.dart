// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate/utils/colors_utils.dart';
import 'package:boilerplate/utils/validation_utils.dart';
import '../../../base_classes/base_button.dart';
import '../../../utils/custom_dialog_utils.dart';
import '../../../utils/dimensions_utils.dart';
import '../../../utils/enum_utils.dart';
import '../../../utils/functions_utils.dart';
import '../../../base_classes/base_text.dart';
import '../../../base_classes/base_textField.dart';
import '../../../bloc/auth/forgot_password/forgot_password_bloc.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/bloc_utils.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/navigation_utils.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/image_widget_util.dart';
import '../../../widgets/screen_title_widget.dart';
import '../../main/dashboard/dashboard_screen.dart';
import '../sign_in/sign_in_screen.dart';

class ForgotPasswordBody extends StatelessWidget {
  late BlocUtils blocUtils;
  late ForgotPasswordBloc forgotPasswordBloc;

  ForgotPasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocUtils = BlocUtils(context: context);
    forgotPasswordBloc = blocUtils.getForgotPasswordBloc();

    return _blocView();
  }
}

extension on ForgotPasswordBody {
  //Bloc view
  Widget _blocView() {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        builder: ((context, state) {
      return _contentView();
    }), listener: (context, state) {
      //Forgot password success
      if (state is ForgotPasswordSuccessState) {
        hideCustomDialog();

        showToastMessage(forgotPasswordBloc.context,
            message: "4 digit verification code sent to email Successfully");

        forgotPasswordBloc.isEmailVerified = true;
      }
      //Forgot password error
      else if (state is ForgotPasswordErrorState) {
        hideCustomDialog();

        showToastMessage(forgotPasswordBloc.context,
            message: state.errorModel!.message.returnString(),
            status: MessageStatusEnum.error);
      }
      //Loading
      else if (state is LoadingState) {
        showLoader();
      } else if (state is VerifyNewPasswordSuccessState) {
        hideCustomDialog();

        showToastMessage(forgotPasswordBloc.context,
            message: "Password changed successfully");

        // NavigationUtils.getTo(ResetPasswordScreen(
        //     email: forgotPasswordBloc.controllerEmail.text));
        NavigationUtils.getOffAll(SignInScreen());
      } else if (state is VerifyNewPasswordErrorState) {
        hideCustomDialog();
        showToastMessage(forgotPasswordBloc.context,
            message: state.errorModel!.message.returnString(),
            status: MessageStatusEnum.error);
      } else if (state is ChangePasswordVisibilityState) {
        forgotPasswordBloc.isPasswordVisible = state.value;
      }
    });
  }

  //Content view
  Widget _contentView() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getLinearGradient(isVerticalGradient: true),
        ),
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: dim14,
                  right: dim14,
                  top: dim120,
                  bottom: dimMainSpaceBottom),
              child: Form(
                key: forgotPasswordBloc.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      imgAssetWidget(
                        'app_icon.png',
                        height: dim80,
                        color: ColorsUtils.colorWhite,
                      ),
                      const SizedBox(height: dim90),
                      //Enter email associate with account

                      Card(
                        color: ColorsUtils.colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: dim18,
                            vertical: dim24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BaseText(
                                text: forgotPasswordBloc.isEmailVerified
                                    ? "Set New Password"
                                    : "Forgot Password",
                                fontSize: dim18,
                                myFont: MyFont.medium,
                                color: ColorsUtils.colorBase,
                              ),
                              const SizedBox(height: dim20),

                              if (forgotPasswordBloc.isEmailVerified) ...[
                                BaseTextField(
                                  forgotPasswordBloc.context,
                                  controller:
                                      forgotPasswordBloc.controllerOtpCode,
                                  borderRadius: BorderRadius.circular(dim8),
                                  hintText: "Enter code",
                                  validatorFun: (value) {
                                    if (value.isNullEmptyString()) {
                                      return "Please enter code";
                                    } else if (value!.length != 4) {
                                      return "Please enter valid 4 digit code";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  textInputType: TextInputType.number,
                                ),
                                const SizedBox(height: dim10),
                                BaseTextField(
                                  forgotPasswordBloc.context,
                                  controller:
                                      forgotPasswordBloc.controllerPassword,
                                  borderRadius: BorderRadius.circular(8),
                                  hintText: LocaleKeys.new_password.tr(),
                                  obscureText:
                                      !forgotPasswordBloc.isPasswordVisible,
                                  // prefixIcon: Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(left: dim12),
                                  //       child: svgImgAssetWidget('ic_lock'),
                                  //     ),
                                  //   ],
                                  // ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: dim12),
                                        child: InkWell(
                                          onTap: () {
                                            forgotPasswordBloc.add(
                                                ChangePasswordVisibilityEvent(
                                                    value: !forgotPasswordBloc
                                                        .isPasswordVisible));
                                          },
                                          child: forgotPasswordBloc
                                                  .isPasswordVisible
                                              ? svgImgAssetWidget(
                                                  'ic_eye_on',
                                                )
                                              : svgImgAssetWidget(
                                                  'ic_eye_off',
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else
                                //Email Id
                                BaseTextField(
                                  forgotPasswordBloc.context,
                                  controller:
                                      forgotPasswordBloc.controllerEmail,
                                  borderRadius: BorderRadius.circular(dim8),
                                  hintText: LocaleKeys.email_id.tr(),
                                  validatorFun: (value) {
                                    if (value.isNullEmptyString()) {
                                      return LocaleKeys.enter_email_address
                                          .tr();
                                    } else if (!value.validateEmail()) {
                                      return LocaleKeys.email_not_valid.tr();
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  prefixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: dim12),
                                        child: svgImgAssetWidget('ic_email'),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: dim20),
                              //Send
                              BaseGradientButton(
                                LocaleKeys.submit.tr(),
                                () {
                                  if (forgotPasswordBloc.formKey.currentState!
                                      .validate()) {
                                    NavigationUtils.getOffAll(
                                        const DashboardScreen());

                                    ///TODO: Function of call api
                                    // FocusManager.instance.primaryFocus
                                    //     ?.unfocus();
                                    // if (forgotPasswordBloc.isEmailVerified) {
                                    //   forgotPasswordBloc
                                    //       .add(VerifyNewPasswordEvent());
                                    // } else {
                                    //   forgotPasswordBloc
                                    //       .add(ForgotPasswordUserEvent(
                                    //     email: forgotPasswordBloc
                                    //         .controllerEmail.text,
                                    //   ));
                                    // }
                                  }
                                },
                                borderRadius: dim8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: dim20),
                child: InkWell(
                  onTap: () {
                    NavigationUtils.getBack();
                  },
                  child: svgImgAssetWidget(
                    'ic_arrow_back',
                    color: ColorsUtils.colorWhite,
                    height: dim24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
