import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:saur_customer/models/state_district_model.dart';

class StateDistrictListModel {
  List<StateDistrictModel>? states;
  StateDistrictListModel({
    this.states,
  });

  StateDistrictListModel copyWith({
    List<StateDistrictModel>? states,
  }) {
    return StateDistrictListModel(
      states: states ?? this.states,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'states': states?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StateDistrictListModel.fromMap(Map<String, dynamic> map) {
    return StateDistrictListModel(
      states: map['states'] != null
          ? List<StateDistrictModel>.from(
              map['states']?.map((x) => StateDistrictModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateDistrictListModel.fromJson(String source) =>
      StateDistrictListModel.fromMap(json.decode(source));

  @override
  String toString() => 'StateDistrictListModel(states: $states)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StateDistrictListModel && listEquals(other.states, states);
  }

  @override
  int get hashCode => states.hashCode;
}
