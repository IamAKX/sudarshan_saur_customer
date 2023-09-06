import 'dart:convert';

import 'package:flutter/foundation.dart';

class StateDistrictModel {
  String? state;
  List<String>? districts;
  StateDistrictModel({
    this.state,
    this.districts,
  });

  StateDistrictModel copyWith({
    String? state,
    List<String>? districts,
  }) {
    return StateDistrictModel(
      state: state ?? this.state,
      districts: districts ?? this.districts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'districts': districts,
    };
  }

  factory StateDistrictModel.fromMap(Map<String, dynamic> map) {
    return StateDistrictModel(
      state: map['state'],
      districts: List<String>.from(map['districts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StateDistrictModel.fromJson(String source) =>
      StateDistrictModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'StateDistrictModel(state: $state, districts: $districts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StateDistrictModel &&
        other.state == state &&
        listEquals(other.districts, districts);
  }

  @override
  int get hashCode => state.hashCode ^ districts.hashCode;
}
