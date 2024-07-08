// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate/utils/validation_utils.dart';
import 'package:tuple/tuple.dart';

import '../../../base_classes/base_button.dart';
import '../../../base_classes/base_text.dart';
import '../../../base_classes/base_textField.dart';
import '../../../bloc/auth/sign_in/sign_in_bloc.dart';
import '../../../model/global/custom_tab_model.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/bloc_utils.dart';
import '../../../utils/colors_utils.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/custom_dialog_utils.dart';
import '../../../utils/dimensions_utils.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/functions_utils.dart';
import '../../../utils/navigation_utils.dart';
import '../../../widgets/checkbox_widget.dart';
import '../../../widgets/image_widget_util.dart';
import '../../../widgets/screen_title_widget.dart';
import '../../main/dashboard/dashboard_screen.dart';
import '../forgot_password/forgot_password_screen.dart';

class SignInBody extends StatelessWidget {
  late BlocUtils blocUtils;
  late SignInBloc signInBloc;

  final bool showBackArrow;

  SignInBody({Key? key, required this.showBackArrow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocUtils = BlocUtils(context: context);
    signInBloc = blocUtils.getSignInBloc();

    //Get credentials from preference
    //Get remember me data
    Tuple3 credentials = getCredentials();

    if (credentials.item1) {
      signInBloc.isRemember = credentials.item1;
      signInBloc.controllerEmail.text = credentials.item2;
      signInBloc.controllerPassword.text = credentials.item3;
    }

    return _blocView();
  }
}

extension on SignInBody {
  //Bloc view
  Widget _blocView() {
    return MultiBlocListener(
      listeners: [
        //Sign in bloc
        BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            //Sign in user success
            if (state is SignInSuccessState) {
              //Save credentials in preference
              if (signInBloc.isRemember) {
                saveCredentials(
                  isRemember: signInBloc.isRemember,
                  email: signInBloc.controllerEmail.text,
                  password: signInBloc.controllerPassword.text,
                );
              } else {
                saveCredentials(
                  isRemember: signInBloc.isRemember,
                  email: '',
                  password: '',
                );
              }

              signInBloc.onSignInSuccess(
                  userModel: state.loginSuccessModel!, context: context);
            }
            //Sign in user error
            else if (state is SignInErrorState) {
              signInBloc.onSignInError(errorModel: state.errorModel!);
            }
            //Loading
            else if (state is LoadingState) {
              showLoader();
            }
          },
        ),
      ],
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          //Change Password Visibility state
          if (state is ChangePasswordVisibilityState) {
            signInBloc.isPasswordVisible = state.value;
          }
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: getLinearGradient(isVerticalGradient: true),
              ),
              height: double.infinity,
              padding: const EdgeInsets.only(
                  left: dim14,
                  right: dim14,
                  top: dim80,
                  bottom: dimMainSpaceBottom),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imgAssetWidget(
                      'app_icon.png',
                      height: dim80,
                      color: ColorsUtils.colorWhite,
                    ),
                    const SizedBox(height: dim40),
                    // _buildSignInTitleWidget(),

                    _contentView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Tab bar view

  //Top welcome view
  Align _buildTopWelcomeView() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // imgAssetWidget(
          //   'app_logo.png',
          //   height: dim50,
          // ),
          // const SizedBox(
          //   height: dim28,
          // ),
          BaseText(
            text: "Welcome!",
            fontSize: dim18,
            myFont: MyFont.semiBold,
          ),
          BaseText(
            text: "Sign in to continue to Orion",
            fontSize: dim16,
            myFont: MyFont.regular,
          ),
        ],
      ),
    );
  }

  //Content view
  Widget _contentView() {
    return Card(
      color: ColorsUtils.colorWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: dim18,
          vertical: dim24,
        ),
        child: Form(
          key: signInBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseText(
                text: "Log in to your account",
                fontSize: dim24,
                myFont: MyFont.semiBold,
              ),
              const SizedBox(height: dim8),
              BaseText(
                text: "Welcome back!",
                fontSize: dim18,
                color: ColorsUtils.colorBase,
                myFont: MyFont.medium,
              ),
              const SizedBox(height: dim20),

              BaseText(
                text: "Email",
                myFont: MyFont.medium,
              ),
              const SizedBox(height: dim6),
              //Email Id
              BaseTextField(
                signInBloc.context,
                controller: signInBloc.controllerEmail,
                borderRadius: BorderRadius.circular(8),
                validatorFun: (value) {
                  if (value.isNullEmptyString()) {
                    return LocaleKeys.enter_email_address.tr();
                  } else if (!value.validateEmail()) {
                    return LocaleKeys.email_not_valid.tr();
                  }
                  return null;
                },
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: dim12),
                      child: svgImgAssetWidget('ic_email'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: dim6),
              BaseText(
                text: LocaleKeys.password.tr(),
                myFont: MyFont.medium,
              ),
              const SizedBox(height: dim6),
              //Password
              BaseTextField(
                signInBloc.context,
                controller: signInBloc.controllerPassword,
                borderRadius: BorderRadius.circular(8),
                // hintText: LocaleKeys.password.tr(),
                obscureText: !signInBloc.isPasswordVisible,
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: dim12),
                      child: svgImgAssetWidget('ic_lock'),
                    ),
                  ],
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: dim12),
                      child: InkWell(
                        onTap: () {
                          signInBloc.add(ChangePasswordVisibilityEvent(
                              value: !signInBloc.isPasswordVisible));
                        },
                        child: signInBloc.isPasswordVisible
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
                textInputAction: TextInputAction.done,
                validatorFun: (value) {
                  if (value.isNullEmptyString()) {
                    return LocaleKeys.enter_password.tr();
                  } else if (!value.checkLength()) {
                    return LocaleKeys.password_length.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: dim10),
              //Remember Me
              CheckboxWidget(
                text: 'Remember Me',
                isSelected: signInBloc.isRemember,
                onToggle: (value) {
                  signInBloc.isRemember = value;
                  debugLogText('isRemember ==> ${signInBloc.isRemember}');
                },
                myFont: MyFont.medium,
              ),
              const SizedBox(height: dim10),
              //Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    removeFocus(signInBloc.context);

                    NavigationUtils.getTo(const ForgotPasswordScreen());
                  },
                  child: BaseText(
                    text: LocaleKeys.forgot_your_password.tr(),
                    color: ColorsUtils.colorBase,
                    myFont: MyFont.medium,
                  ),
                ),
              ),
              const SizedBox(height: dim30),
              //Sign In
              BaseGradientButton(
                LocaleKeys.login.tr(),
                () {
                  removeFocus(signInBloc.context);
                  if (signInBloc.formKey.currentState!.validate()) {
                    NavigationUtils.getOffAll(const DashboardScreen());

                    // signInBloc.add(
                    //   SignInUserEvent(
                    //     bodyData: {
                    //       'email': signInBloc.controllerEmail.text,
                    //       'password': signInBloc.controllerPassword.text,
                    //     },
                    //   ),
                    // );
                  }
                },
                borderRadius: dim8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on SignInBody {
  //Login Title
  Widget _buildSignInTitleWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ScreenTitleWidget(
        title: LocaleKeys.login_as.tr(),
      ),
    );
  }
}
