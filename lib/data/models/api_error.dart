import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

class ApiError {
  String message;

  ApiError({
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
