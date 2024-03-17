import 'dart:convert';

import 'package:saur_customer/models/otp_data.dart';

class OTPResponse {
  String? status;
  String? code;
  String? description;
  OtpData? data;
  OTPResponse({
    this.status,
    this.code,
    this.description,
    this.data,
  });

  OTPResponse copyWith({
    String? status,
    String? code,
    String? description,
    OtpData? data,
  }) {
    return OTPResponse(
      status: status ?? this.status,
      code: code ?? this.code,
      description: description ?? this.description,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (status != null) {
      result.addAll({'status': status});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }

    return result;
  }

  factory OTPResponse.fromMap(Map<String, dynamic> map) {
    return OTPResponse(
      status: map['status'],
      code: map['code'],
      description: map['description'],
      data: map['data'] != null ? OtpData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPResponse.fromJson(String source) =>
      OTPResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OTPResponse(status: $status, code: $code, description: $description, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OTPResponse &&
        other.status == status &&
        other.code == code &&
        other.description == description &&
        other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        code.hashCode ^
        description.hashCode ^
        data.hashCode;
  }
}
