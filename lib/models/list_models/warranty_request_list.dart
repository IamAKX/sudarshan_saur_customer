import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/warranty_model.dart';

class WarrantyRequestList {
  List<WarrantyModel>? data;
  WarrantyRequestList({
    this.data,
  });

  WarrantyRequestList copyWith({
    List<WarrantyModel>? data,
  }) {
    return WarrantyRequestList(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory WarrantyRequestList.fromMap(Map<String, dynamic> map) {
    return WarrantyRequestList(
      data: map['data'] != null
          ? List<WarrantyModel>.from(
              map['data']?.map((x) => WarrantyModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyRequestList.fromJson(String source) =>
      WarrantyRequestList.fromMap(json.decode(source));

  @override
  String toString() => 'WarrantyRequestList(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyRequestList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
