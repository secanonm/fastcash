import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import 'color.dart';

class AccordionController extends GetxController {
  var isOpen = false.obs;
  var isOpen2 = false.obs;
  updateData(value) => isOpen.value = value;
  updateData2() => isOpen2.value = !isOpen2.value;
}

// ignore: must_be_immutable
class MyAccordion extends StatelessWidget {
  final String heading;
  final String subtitle;
  final TextAlign subtitleAlign;
  final double margin;
  final bool isSecond;
  final bool isOpen;
  MyAccordion(
      {Key? key,
      required this.heading,
      required this.subtitle,
      this.margin = 10,
      this.subtitleAlign = TextAlign.left,
      this.isSecond = false,
      this.isOpen = false})
      : super(key: key);

  AccordionController controller = Get.put(AccordionController());

  @override
  Widget build(BuildContext context) {
    controller.updateData(isOpen);
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  isSecond
                      ? controller.updateData2()
                      : controller.updateData(!controller.isOpen.value);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: isSecond
                          ? controller.isOpen2.value
                              ? MyColor.yellow
                              : MyColor.primary
                          : controller.isOpen.value
                              ? MyColor.yellow
                              : MyColor.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: lighten(
                              isSecond
                                  ? controller.isOpen2.value
                                      ? MyColor.yellow
                                      : MyColor.primary
                                  : controller.isOpen.value
                                      ? MyColor.yellow
                                      : MyColor.primary,
                              .3))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              heading,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            isSecond
                                ? controller.isOpen2.value
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded
                                : controller.isOpen.value
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                        ),
                      ]),
                ),
              ),
              if (isSecond ? controller.isOpen2.value : controller.isOpen.value)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorDark,
                      border: Border.all(
                          width: 2,
                          color: lighten(Theme.of(context).primaryColorDark))),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(subtitle,
                      textAlign: subtitleAlign,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
            ],
          ),
        ));
  }
}
