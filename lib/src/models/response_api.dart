import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  bool? succes;
  String? message;
  dynamic data;

  ResponseApi({
    this.succes,
    this.message,
    this.data,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        succes: json["succes"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "data": data,
      };
}
