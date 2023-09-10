import 'dart:convert';

class QuestionModel {
  int? questionId;
   String? questionText;
  QuestionModel({
    this.questionId,
    this.questionText,
  });

  QuestionModel copyWith({
    int? questionId,
    String? questionText,
  }) {
    return QuestionModel(
      questionId: questionId ?? this.questionId,
      questionText: questionText ?? this.questionText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'questionText': questionText,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionId']?.toInt(),
      questionText: map['questionText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source));

  @override
  String toString() => 'QuestionModel(questionId: $questionId, questionText: $questionText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QuestionModel &&
      other.questionId == questionId &&
      other.questionText == questionText;
  }

  @override
  int get hashCode => questionId.hashCode ^ questionText.hashCode;
   }
