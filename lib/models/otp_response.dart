import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/otp_data.dart';

class OTPResponse {
  Map<String, dynamic>? Response;
  String? Status;
  OTPResponse({
    this.Response,
    this.Status,
  });

  OTPResponse copyWith({
    Map<String, dynamic>? Response,
    String? Status,
  }) {
    return OTPResponse(
      Response: Response ?? this.Response,
      Status: Status ?? this.Status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (Response != null) {
      result.addAll({'Response': Response});
    }
    if (Status != null) {
      result.addAll({'Status': Status});
    }

    return result;
  }

  factory OTPResponse.fromMap(Map<String, dynamic> map) {
    return OTPResponse(
      Response: Map<String, dynamic>.from(map['Response']),
      Status: map['Status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPResponse.fromJson(String source) =>
      OTPResponse.fromMap(json.decode(source));

  @override
  String toString() => 'OTPResponse(Response: $Response, Status: $Status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OTPResponse &&
        mapEquals(other.Response, Response) &&
        other.Status == Status;
  }

  @override
  int get hashCode => Response.hashCode ^ Status.hashCode;
}
