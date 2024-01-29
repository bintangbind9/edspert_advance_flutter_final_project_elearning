class ExerciseResponse {
  final int? status;
  final String? message;
  final List<Exercise>? data;

  ExerciseResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) =>
      ExerciseResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Exercise>.from(
                json["data"]!.map((x) => Exercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Exercise {
  final String? exerciseId;
  final String? exerciseTitle;
  final String? accessType;
  final String? icon;
  final String? exerciseUserStatus;
  final String? jumlahSoal;
  final int? jumlahDone;

  Exercise({
    this.exerciseId,
    this.exerciseTitle,
    this.accessType,
    this.icon,
    this.exerciseUserStatus,
    this.jumlahSoal,
    this.jumlahDone,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exercise_id"],
        exerciseTitle: json["exercise_title"],
        accessType: json["access_type"],
        icon: json["icon"],
        exerciseUserStatus: json["exercise_user_status"],
        jumlahSoal: json["jumlah_soal"],
        jumlahDone: json["jumlah_done"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "exercise_title": exerciseTitle,
        "access_type": accessType,
        "icon": icon,
        "exercise_user_status": exerciseUserStatus,
        "jumlah_soal": jumlahSoal,
        "jumlah_done": jumlahDone,
      };
}
