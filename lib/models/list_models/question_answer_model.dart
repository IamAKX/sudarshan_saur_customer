import 'dart:convert';

import 'package:saur_customer/models/list_models/question_model.dart';

class QuestionAnswerModel {
  QuestionModel? questions;
  String? answerText;
  QuestionAnswerModel({
    this.questions,
    this.answerText,
  });

  QuestionAnswerModel copyWith({
    QuestionModel? questions,
    String? answerText,
  }) {
    return QuestionAnswerModel(
      questions: questions ?? this.questions,
      answerText: answerText ?? this.answerText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questions': questions?.toMap(),
      'answerText': answerText,
    };
  }

  factory QuestionAnswerModel.fromMap(Map<String, dynamic> map) {
    return QuestionAnswerModel(
      questions: map['questions'] != null
          ? QuestionModel.fromMap(map['questions'])
          : null,
      answerText: map['answerText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionAnswerModel.fromJson(String source) =>
      QuestionAnswerModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'QuestionAnswerModel(questions: $questions, answerText: $answerText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionAnswerModel &&
        other.questions == questions &&
        other.answerText == answerText;
  }

  @override
  int get hashCode => questions.hashCode ^ answerText.hashCode;
}
