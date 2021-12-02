import 'package:e_complaint/constants/constants.dart';
import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/constants/themes.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.autoFocused,
    required this.hintText,
    this.maxLength,
    this.maxLines,
    this.validation,
    this.inputType,
    this.inputAction,
    this.myFocus,
    this.nextFocus,
    this.onSave, this.readOnly,
    this.controller,
  }) : super(key: key);

  final bool? autoFocused;


  final String hintText;
  final int? maxLength;
  final int? maxLines;
  final ValidationType? validation;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FocusNode? myFocus;
  final FocusNode? nextFocus;
  final Function? onSave;
  final bool? readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kFormFieldPadding,
      child: TextFormField(
          autofocus: autoFocused ?? false,
          focusNode: myFocus,
          readOnly: readOnly ?? false,
          cursorHeight: 25.0,
          cursorColor: kMainColor,
          textCapitalization: TextCapitalization.sentences,
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          keyboardType: inputType,
          textInputAction: inputAction,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: kFieldHintStyle,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: kInputBorder,
            focusedBorder: kFocusedInputBorder,
          ),
          textAlignVertical: TextAlignVertical.center,
          style: kFieldTextStyle,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            switch (validation) {
              case ValidationType.name:
                {
                  if (value == null || value.isEmpty) {
                    return kTextRequired;
                  } else if (value.length < 3) {
                    return kTextTooShort;
                  }
                  return null;
                }

              case ValidationType.phoneNumber:
                {
                  if (value == null || value.isEmpty) {
                    return kTextRequired;
                  } else if (value.length < 10) {
                    return kTextEnterValid;
                  }
                  return null;
                }
              default:
                {
                  return null;
                }
            }
          },
          onSaved: (value) =>
          onSave == null ? {} : onSave!(value),
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(nextFocus);
          }),
    );
  }
}