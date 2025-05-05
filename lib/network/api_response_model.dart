class ApiResponseModel {
  dynamic data;
  String? status;
  String? message;

  ApiResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseModel(
        data: json["data"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    if(data!=null)
    "data": data,
    "status": status,
    "message": message,
  };
}
