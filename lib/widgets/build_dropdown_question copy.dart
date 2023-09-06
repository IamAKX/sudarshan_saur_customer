import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'gaps.dart';

class BuildDropdownQuestion extends StatefulWidget {
  BuildDropdownQuestion(
      {super.key,
      required this.question,
      this.selectedAnswer,
      required this.options});
  final String? question;
  String? selectedAnswer;
  final List<String> options;

  @override
  State<BuildDropdownQuestion> createState() => _BuildDropdownQuestionState();
}

class _BuildDropdownQuestionState extends State<BuildDropdownQuestion> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
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
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: widget.selectedAnswer,
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
