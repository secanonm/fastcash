// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'color.dart';

// ignore: must_be_immutable
class MyInputField extends StatelessWidget {
  GlobalKey<FormFieldState>? keyController;
  TextEditingController? textController;
  final bool autofocus;
  final maxLength;
  final int maxLine;
  final label;
  final helperText;
  final hintText;
  final String errorText;
  final double fontSize;
  final double margin;
  final double borderRadius;
  final bool isBox;
  final bool enabled;
  final void Function()? onTap;
  final Widget? suffix;
  MyInputField(
      {Key? key,
      this.keyController,
      this.textController,
      this.label,
      required this.hintText,
      required this.errorText,
      this.autofocus = false,
      this.helperText,
      this.maxLength,
      this.maxLine = 1,
      this.fontSize = 14,
      this.margin = 10,
      this.isBox = false,
      this.borderRadius = 10,
      this.suffix,
      this.enabled = true,
      this.onTap})
      : super(key: key) {
    keyController = keyController ?? GlobalKey<FormFieldState>();
    textController = textController ?? TextEditingController();
    labelColor =
        enabled ? MyColor.green.withOpacity(.9) : lighten(MyColor.disabled);
  }

  var labelColor;
  var hintColor = MyColor.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin, vertical: margin * .8),
      child: StatefulBuilder(builder: (context, setState) {
        return TextFormField(
          enabled: enabled,
          key: keyController ?? GlobalKey<FormFieldState>(),
          keyboardType: isBox ? TextInputType.multiline : TextInputType.text,
          onChanged: (val) {
            keyController?.currentState!.validate();
          },
          validator: (value) {
            if (value.toString().isEmpty) {
              setState((() {
                labelColor = MyColor.red;
                hintColor = MyColor.red;
              }));
              return errorText;
            } else {
              setState((() {
                labelColor = MyColor.green;
                hintColor = MyColor.white;
              }));
              return null;
            }
          },
          autofocus: autofocus,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          maxLength: maxLength,
          controller: textController,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: isBox ? null : maxLine,
          minLines: isBox ? maxLine : 1,
          onTap: onTap,
          decoration: InputDecoration(
              helperText: helperText,
              hintText: hintText,
              suffixIcon: suffix,
              label: label != null
                  ? Text(
                      label,
                    )
                  : null,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: hintColor),
              helperStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).dividerColor.withOpacity(0.8)),
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: fontSize, color: labelColor),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(
                      color: Theme.of(context).disabledColor, width: 2)),
              // hover
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide:
                      BorderSide(color: Theme.of(context).cardColor, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide:
                      BorderSide(color: Theme.of(context).cardColor, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              fillColor: Theme.of(context).primaryColor),
        );
      }),
    );
  }
}
