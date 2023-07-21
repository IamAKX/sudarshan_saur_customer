import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/user_model.dart';

class CustomerListModel {
  List<UserModel>? data;
  CustomerListModel({
    this.data,
  });

  CustomerListModel copyWith({
    List<UserModel>? data,
  }) {
    return CustomerListModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CustomerListModel.fromMap(Map<String, dynamic> map) {
    return CustomerListModel(
      data: map['data'] != null
          ? List<UserModel>.from(map['data']?.map((x) => UserModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerListModel.fromJson(String source) =>
      CustomerListModel.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerListModel(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerListModel && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
