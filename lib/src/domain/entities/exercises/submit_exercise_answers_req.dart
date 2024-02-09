class SubmitExerciseAnswersReq {
  final String userEmail;
  final String exerciseId;
  final List<String> bankQuestionIds;
  final List<String> studentAnswers;

  SubmitExerciseAnswersReq({
    required this.userEmail,
    required this.exerciseId,
    required this.bankQuestionIds,
    required this.studentAnswers,
  });

  factory SubmitExerciseAnswersReq.fromJson(Map<String, dynamic> json) =>
      SubmitExerciseAnswersReq(
        userEmail: json["user_email"],
        exerciseId: json["exercise_id"],
        bankQuestionIds: json["bank_question_id"] == null
            ? []
            : List<String>.from(json["bank_question_id"]!.map((x) => x)),
        studentAnswers: json["student_answer"] == null
            ? []
            : List<String>.from(json["student_answer"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_email": userEmail,
        "exercise_id": exerciseId,
        "bank_question_id": List<String>.from(bankQuestionIds.map((x) => x)),
        "student_answer": List<String>.from(studentAnswers.map((x) => x)),
      };
}
