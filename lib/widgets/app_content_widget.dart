// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

class AppContentWidget extends StatefulWidget {
  Widget? childContent;
  final bool? showBack;
  final bool? showAppBar;
  final bool fromCreateMsgTask;
  final Function? onBackPressed;
  final Function? onVaultIconPressed;
  final Function? onNotificationPressed;
  final Function? onAccountIconPressed;
  bool isFromSignUp = false;
  final Function? onAppNamePressed;

  AppContentWidget(
      {Key? key,
      required this.childContent,
      this.showBack = true,
      this.showAppBar = true,
      this.fromCreateMsgTask = false,
      this.onBackPressed,
      this.isFromSignUp = false,
      this.onNotificationPressed,
      this.onVaultIconPressed,
      this.onAccountIconPressed,
      this.onAppNamePressed})
      : super(key: key);

  @override
  State<AppContentWidget> createState() => _AppContentWidgetState();
}

class _AppContentWidgetState extends State<AppContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (widget.showAppBar!) ...[
              AppBarWidget(
                showBack: widget.showBack,
                title: "dfs",
                onBackPressed: widget.onBackPressed,
              ),
            ],
            widget.childContent!,
          ],
        )
      ],
    );
  }
}
