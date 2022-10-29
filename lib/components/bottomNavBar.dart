import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'color.dart';
import 'route.dart';

class MyBottomNavBar extends StatelessWidget {
  final int index;
  final bool isInsider;
  const MyBottomNavBar({Key? key, required this.index, this.isInsider = true})
      : super(key: key);

  final pages = const [
    '/dashboard',
    '/about',
  ];
  @override
  Widget build(BuildContext context) {
    var colo = lighten(Theme.of(context).cardColor, .3).withOpacity(0.8);
    return Container(
        height: 65,
        padding: const EdgeInsets.only(top: 7),
        decoration: BoxDecoration(color: MyColor.pBackground, boxShadow: const [
          BoxShadow(
            color: Color(0xFF070F16),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ]),
        child: CustomNavigationBar(
            // borderRadius: Radius.circular(10),
            iconSize: 28.0,
            selectedColor: Colors.white,
            strokeColor: Colors.white,
            unSelectedColor: colo,
            backgroundColor: MyColor.pBackground,
            items: [
              CustomNavigationBarItem(
                  icon: const Icon(Icons.assessment_rounded),
                  title: Text("DASHBOARD",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 9, height: 2, color: colo)),
                  selectedTitle: Text("DASHBOARD",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 9, height: 2.5))),
              CustomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                  title: Text("ABOUT",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 9, height: 2, color: colo)),
                  selectedTitle: Text("ABOUT",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 9, height: 2.5))),
            ],
            currentIndex: index - 1,
            onTap: (value) {
              MyRoute.offNamed(pages[value]);
            }));
  }
}
