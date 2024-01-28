class ResponseModel<T> {
  String? message;
  int? status;
  T? data;
  late Function(T data) dataToJson;
  late T Function(dynamic data) dataFromJson;

  ResponseModel({
    this.data,
    this.message,
    this.status,
    required this.dataFromJson,
    required this.dataToJson,
  });

  ResponseModel.fromJson({
    required Map<String, dynamic> json,
    required Function(T data) toJsonData,
    required T Function(dynamic data) fromJsonData,
  }) {
    data = fromJsonData(json['data']);
    message = json['message'];
    status = json['status'];
    dataFromJson = fromJsonData;
    dataToJson = toJsonData;
  }
}
