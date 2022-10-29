import 'package:flutter/material.dart';

import 'route.dart';

class MyAppBar extends AppBar {
  final String appTitle;
  final PreferredSizeWidget? appBottom;
  final bool isBack;
  MyAppBar({
    Key? key,
    required this.appTitle,
    this.appBottom,
    this.isBack = true,
    List<Widget>? actions,
  }) : super(
            key: key,
            titleSpacing: isBack ? 0 : 20,
            title: Text(appTitle),
            automaticallyImplyLeading: false,
            bottom: appBottom,
            leading: isBack
                ? InkWell(
                    onTap: () => MyRoute.back(),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                    ),
                  )
                : null,
            actions: actions);
}
