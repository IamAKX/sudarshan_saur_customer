import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'gaps.dart';

class BuildInputTextQuestion extends StatefulWidget {
  BuildInputTextQuestion({
    super.key,
    this.showError,
    required this.question,
    required this.answer,
    this.textInputType,
  });
  final String question;
  bool? showError;
  final TextEditingController answer;
  final TextInputType? textInputType;

  @override
  State<BuildInputTextQuestion> createState() => _BuildInputTextQuestionState();
}

class _BuildInputTextQuestionState extends State<BuildInputTextQuestion> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalGap(defaultPadding),
            TextField(
              keyboardType: widget.textInputType ?? TextInputType.name,
              autocorrect: true,
              controller: widget.answer,
              decoration: secondaryTextFieldDecoration('Type here...'),
            ),
          ],
        ),
      ),
    );
  }
}
