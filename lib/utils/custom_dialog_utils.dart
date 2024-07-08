import 'package:boilerplate/utils/validation_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;

import '../base_classes/base_button.dart';
import '../base_classes/base_text.dart';
import '../model/global/DropDownModel.dart';
import '../translations/locale_keys.g.dart';
import '../widgets/image_widget_util.dart';
import 'colors_utils.dart';
import 'constant_utils.dart';
import 'dimensions_utils.dart';
import 'fonts_utils.dart';
import 'functions_utils.dart';
import 'navigation_utils.dart';

//Loader dialog
void showLoader({bool isBarrierDismissible = true}) {
  ConstantUtils.isLoading = true;
  Get.generalDialog(
      barrierDismissible: isBarrierDismissible,
      barrierLabel:
          MaterialLocalizations.of(globalContext).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      pageBuilder: (context, anim1, anim2) {
        return WillPopScope(
          onWillPop: () async {
            if (isBarrierDismissible) {
              ConstantUtils.isLoading = false;
              return true;
            } else {
              return false;
            }
          },
          child: Center(
            child: StatefulBuilder(
              builder: (context, setState) {
                return Material(
                  borderRadius: BorderRadius.circular(dim14),
                  color: Colors.black38,
                  child: Container(
                    padding: const EdgeInsets.all(dim14),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                          color: ColorsUtils.colorWhite,
                          backgroundColor: ColorsUtils.colorBase,
                        ),
                        const SizedBox(height: dim20),
                        BaseText(
                            text: '${LocaleKeys.loading.tr()}...',
                            color: ColorsUtils.colorWhite,
                            fontSize: dim18),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      });
}

//Hide dialog
void hideCustomDialog({BuildContext? context, bool isPop = false}) async {
  NavigationUtils.getBack();
  ConstantUtils.isLoading = false;
}

//Full screens dialog
Future showFullScreenDialog(
    {required Widget widget,
    bool outsideTouchDismiss = true,
    Color? barrierColor}) async {
  await Get.generalDialog(
      barrierDismissible: outsideTouchDismiss,
      barrierLabel:
          MaterialLocalizations.of(globalContext).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? ColorsUtils.colorWhite.withOpacity(0.3),
      pageBuilder: (context, anim1, anim2) {
        return widget;
      });
}

//Custom dialog
Future showCustomDialog(
    {required Widget widget, bool outsideTouchDismiss = true}) async {
  await showDialog(
      context: globalContext,
      barrierColor: ColorsUtils.colorTransparent,
      builder: (BuildContext context) {
        return Dialog(
            shadowColor: ColorsUtils.colorWhite,
            backgroundColor: ColorsUtils.colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: widget);
      });
}

Future showOptionsModal({
  required BuildContext context,
  required List<ActionTypeModel> options,
  Function()? onCancel,
  required String title,
}) async {
  // For iOS (Cupertino)
  // if (Theme.of(context).platform == TargetPlatform.iOS) {
  if (true) {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title:
            Center(child: BaseText(text: title, color: ColorsUtils.colorBlack)),
        actions: options.map((option) {
          return CupertinoActionSheetAction(
            onPressed: option.onTap,
            child: BaseText(
              text: option.name,
              color: ColorsUtils.colorBase,
              myFont: MyFont.semiBold,
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: onCancel != null
              ? onCancel
              : () {
                  NavigationUtils.getBack();
                },
          child: BaseText(text: "Cancel"),
        ),
      ),
    );
  }
  // For Android (Material)
  else {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: options.map((option) {
            return ListTile(
              title: Text(option.name),
              onTap: option.onTap,
            );
          }).toList(),
        );
      },
    );
  }
}

// Example usage:
// showOptionsModal(
//   context,
//   ['Option 1', 'Option

// Example usage:
// showOptionsModal(context, ['Option 1', 'Option 2', 'Option 3'], (selectedOption) {
//   print('Selected option: $selectedOption');
// });

//Popup dialog (With Single & Two buttons)
void showPopUpDialog(
    {required String text,
    bool isSingleBtn = true,
    required String textBtn1,
    String? textBtn2,
    String? description,
    required Function? onTapBtn1,
    bool outsideTouchDismiss = false,
    Color? buttonColor1,
    Color? buttonColor2,
    Function? onTapBtn2}) {
  showFullScreenDialog(
    outsideTouchDismiss: outsideTouchDismiss,
    widget: Material(
      color: ColorsUtils.colorTransparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: dim25),
            padding: const EdgeInsets.all(dim25),
            decoration: BoxDecoration(
              color: ColorsUtils.colorWhite,
              borderRadius: BorderRadius.circular(dim15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      NavigationUtils.getBack();
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: dim20, bottom: dim20),
                      child: imgAssetWidget('ic_close.png', height: dim20),
                    ),
                  ),
                ),
                //Text
                BaseText(
                  text: text,
                  fontSize: dim20,
                  myFont: MyFont.semiBold,
                  textAlign: TextAlign.center,
                ),
                if (!description.isNullEmptyString()) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: dim20, vertical: dim14),
                    child: BaseText(
                      text: description,
                      fontSize: dim15,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
                const SizedBox(height: dim20),

                //Single button
                if (isSingleBtn) ...[
                  BaseMaterialButton(
                    textBtn1,
                    () {
                      NavigationUtils.getBack();

                      if (onTapBtn1 != null) {
                        onTapBtn1();
                      }
                    },
                    buttonColor: buttonColor1,
                  ),
                ]
                //Two buttons
                else ...[
                  IntrinsicHeight(
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          //Button 1
                          Expanded(
                            child: BaseOutlinedButton(
                              textBtn1,
                              () {
                                NavigationUtils.getBack();

                                if (onTapBtn1 != null) {
                                  onTapBtn1();
                                }
                              },
                              verticalPadding: dim14,
                              horizontalPadding: dim14,
                              buttonColor: ColorsUtils.colorTransparent,
                              borderColor: buttonColor1,
                              textColor: ColorsUtils.colorBase,
                              borderRadius: dim100,
                              myFont: MyFont.semiBold,
                              fontSize: dim16,
                            ),
                          ),
                          const SizedBox(width: dim10),
                          //Button 2
                          Expanded(
                            child: BaseMaterialButton(
                              textBtn2!,
                              () {
                                NavigationUtils.getBack();

                                if (onTapBtn2 != null) {
                                  onTapBtn2();
                                }
                              },
                              buttonColor: buttonColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//Pick multiple options dialog
Future pickMultipleOptionsDialog({required Widget content}) async {
  await showFullScreenDialog(
      outsideTouchDismiss: true,
      widget: Material(
        color: ColorsUtils.colorTransparent,
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: dimMainSpace),
              decoration: BoxDecoration(
                color: ColorsUtils.colorBase,
                borderRadius: BorderRadius.circular(dim10),
              ),
              child: content,
            ),
            const SizedBox(height: dim15),
            //Cancel
            Material(
              color: ColorsUtils.colorTransparent,
              child: InkWell(
                onTap: () {
                  NavigationUtils.getBack();
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: dimMainSpace, right: dimMainSpace, bottom: dim20),
                  padding: const EdgeInsets.symmetric(vertical: dim20),
                  decoration: BoxDecoration(
                    color: ColorsUtils.colorBase.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(dim10),
                  ),
                  child: BaseText(
                    text: LocaleKeys.cancel.tr(),
                    color: ColorsUtils.colorWhite,
                    myFont: MyFont.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
}

showPopupMenuItemWidget(
  BuildContext context,
  double dx,
  double dy,
  List<PopupMenuEntry<String>> list, {
  Function(String)? onSelectedValue,
  RelativeRect? position,
}) {
  return showMenu<String>(
    context: context,
    position: position ?? RelativeRect.fromLTRB(dx, dy, 20, dy),
    items: list,
    surfaceTintColor: ColorsUtils.colorWhite,
    elevation: 8.0,
  ).then((itemSelected) {
    if (itemSelected == null) return;
    if (onSelectedValue != null) onSelectedValue!(itemSelected);
  });
}
