class QuestionAnswer {
  final String questionId;
  final String answer;

  QuestionAnswer({
    required this.questionId,
    required this.answer,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        questionId: json["questionId"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "answer": answer,
      };
}
