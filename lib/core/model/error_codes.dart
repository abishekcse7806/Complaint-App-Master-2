import 'dart:convert';

ErrorResponse errorCodesFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorCodesToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.data,
  });

  final List<ErrorCode> data;

  ErrorResponse copyWith({
    List<ErrorCode>? data,
  }) =>
      ErrorResponse(
        data: data ?? this.data,
      );

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        data: List<ErrorCode>.from(
            json["data"].map((x) => ErrorCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ErrorCode {
  ErrorCode({
    required this.description,
    required this.code,
  });

  final String description;
  final String code;

  ErrorCode copyWith({
    String? description,
    String? code,
  }) =>
      ErrorCode(
        description: description ?? this.description,
        code: code ?? this.code,
      );

  factory ErrorCode.fromJson(Map<String, dynamic> json) => ErrorCode(
        description: json["description"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
      };
}
