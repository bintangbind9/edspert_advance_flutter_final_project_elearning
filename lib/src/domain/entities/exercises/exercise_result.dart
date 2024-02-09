import 'exercise_model.dart';

class ExerciseResult {
  final Exercise? exercise;
  final Result? result;

  ExerciseResult({
    this.exercise,
    this.result,
  });

  factory ExerciseResult.fromJson(Map<String, dynamic> json) => ExerciseResult(
        exercise: json["exercise"] == null
            ? null
            : Exercise.fromJson(json["exercise"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "exercise": exercise?.toJson(),
        "result": result?.toJson(),
      };
}

class Result {
  final String? jumlahBenar;
  final String? jumlahSalah;
  final String? jumlahTidak;
  final String? jumlahScore;

  Result({
    this.jumlahBenar,
    this.jumlahSalah,
    this.jumlahTidak,
    this.jumlahScore,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        jumlahBenar: json["jumlah_benar"],
        jumlahSalah: json["jumlah_salah"],
        jumlahTidak: json["jumlah_tidak"],
        jumlahScore: json["jumlah_score"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah_benar": jumlahBenar,
        "jumlah_salah": jumlahSalah,
        "jumlah_tidak": jumlahTidak,
        "jumlah_score": jumlahScore,
      };
}
