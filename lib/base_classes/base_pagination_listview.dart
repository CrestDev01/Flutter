import 'package:flutter/material.dart';
import 'package:boilerplate/utils/validation_utils.dart';

import '../utils/colors_utils.dart';

class BasePaginationListView extends StatelessWidget {
  final Widget listViewWidget;
  final Widget emptyViewWidget;
  final Function whenReachToEnd;
  final Function onRefresh;
  final List list;
  final bool isLoading;

  const BasePaginationListView({
    Key? key,
    required this.listViewWidget,
    required this.emptyViewWidget,
    required this.whenReachToEnd,
    required this.onRefresh,
    required this.list,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() {
        onRefresh();
      }),
      color: ColorsUtils.colorBase,
      child: list.isListNullEmpty()
          ? isLoading
              ? Container()
              : Stack(
                  children: [
                    emptyViewWidget,
                    ListView(),
                  ],
                )
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  //Call event to load next page
                  whenReachToEnd();
                }
                return false;
              },
              child: listViewWidget,
            ),
    );
  }
}
