import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'gaps.dart';

class BuildDropdownQuestion extends StatefulWidget {
  BuildDropdownQuestion(
      {super.key,
      required this.question,
      this.selectedAnswer,
      this.showError,
      required this.options});
  final String? question;
  String? selectedAnswer;
  final List<String> options;
  bool? showError;

  @override
  State<BuildDropdownQuestion> createState() => _BuildDropdownQuestionState();
}

class _BuildDropdownQuestionState extends State<BuildDropdownQuestion> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: (widget.showError ?? false) ? Colors.red : Colors.white),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                widget.question!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            horizontalGap(defaultPadding),
            Expanded(
              flex: 3,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  value: widget.selectedAnswer,
                  hint: Text(
                    'Select ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  underline: null,
                  isExpanded: true,
                  items: widget.options
                      .map((val) => DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      widget.selectedAnswer = value!;
                      log(widget.selectedAnswer ?? '');
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
