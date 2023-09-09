import 'dart:convert';

class QuestionModel {
  int? questionId;
  QuestionModel({
    this.questionId,
  });

  QuestionModel copyWith({
    int? questionId,
  }) {
    return QuestionModel(
      questionId: questionId ?? this.questionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));

  @override
  String toString() => 'QuestionModel(questionId: $questionId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionModel && other.questionId == questionId;
  }

  @override
  int get hashCode => questionId.hashCode;
}
