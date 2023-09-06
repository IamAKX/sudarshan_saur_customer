import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'gaps.dart';

class BuildInputTextQuestion extends StatefulWidget {
  const BuildInputTextQuestion({
    super.key,
    required this.question,
    required this.answer,
  });
  final String question;

  final TextEditingController answer;

  @override
  State<BuildInputTextQuestion> createState() => _BuildInputTextQuestionState();
}

class _BuildInputTextQuestionState extends State<BuildInputTextQuestion> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
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
              keyboardType: TextInputType.name,
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
