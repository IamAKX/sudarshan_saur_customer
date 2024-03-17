import 'dart:convert';

class OtpData {
  String? messageid;
  int? totnumber;
  int? totalcredit;
  OtpData({
    this.messageid,
    this.totnumber,
    this.totalcredit,
  });

  OtpData copyWith({
    String? messageid,
    int? totnumber,
    int? totalcredit,
  }) {
    return OtpData(
      messageid: messageid ?? this.messageid,
      totnumber: totnumber ?? this.totnumber,
      totalcredit: totalcredit ?? this.totalcredit,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (messageid != null) {
      result.addAll({'messageid': messageid});
    }
    if (totnumber != null) {
      result.addAll({'totnumber': totnumber});
    }
    if (totalcredit != null) {
      result.addAll({'totalcredit': totalcredit});
    }

    return result;
  }

  factory OtpData.fromMap(Map<String, dynamic> map) {
    return OtpData(
      messageid: map['messageid'],
      totnumber: map['totnumber']?.toInt(),
      totalcredit: map['totalcredit']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpData.fromJson(String source) =>
      OtpData.fromMap(json.decode(source));

  @override
  String toString() =>
      'OtpData(messageid: $messageid, totnumber: $totnumber, totalcredit: $totalcredit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtpData &&
        other.messageid == messageid &&
        other.totnumber == totnumber &&
        other.totalcredit == totalcredit;
  }

  @override
  int get hashCode =>
      messageid.hashCode ^ totnumber.hashCode ^ totalcredit.hashCode;
}
