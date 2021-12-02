import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/constants/themes.dart';
import 'package:flutter/material.dart';

import 'package:e_complaint/core/model/error_codes.dart';
import 'package:e_complaint/core/service/complaints_service.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {Key? key, required this.onChange, required this.selectedError})
      : super(key: key);

  final Function onChange;
  final String selectedError;


  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late Future<List<ErrorCode>> future;

  @override
  void initState() {
    super.initState();
    future = ComplaintsService().getErrorCodes();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownErrors = [];

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<ErrorCode>> snapshot) {
        if (snapshot.hasData) {
          dropdownErrors = snapshot.data!
              .map(
                (error) => DropdownMenuItem<String>(
                  child: Text(error.code),
                  value: error.code,
                ),
              )
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:DropdownButtonFormField<String>(
              items: dropdownErrors,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 30,
              style: kFieldTextStyle,
              decoration: const InputDecoration(
                hintStyle: kFieldHintStyle,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                border: kInputBorder,
                focusedBorder: kFocusedInputBorder,
              ),
              isExpanded: true,
              hint: Text(widget.selectedError),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value==null||value.isEmpty) {
                  return kTextRequired;
                } else {
                  return null;
                }
              },
              onChanged: (newValue) => widget.onChange(newValue),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
