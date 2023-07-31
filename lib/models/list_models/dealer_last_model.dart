import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/dealer_model.dart';

class DealerListModel {
  List<DealerModel>? data;
  DealerListModel({
    this.data,
  });

  DealerListModel copyWith({
    List<DealerModel>? data,
  }) {
    return DealerListModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory DealerListModel.fromMap(Map<String, dynamic> map) {
    return DealerListModel(
      data: map['data'] != null
          ? List<DealerModel>.from(
              map['data']?.map((x) => DealerModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerListModel.fromJson(String source) =>
      DealerListModel.fromMap(json.decode(source));

  @override
  String toString() => 'DealerListModel(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DealerListModel && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
