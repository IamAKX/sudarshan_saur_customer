import 'dart:convert';

class DealerModel {
  String? name;
  String? mobile;
  String? place;
  DealerModel({
    this.name,
    this.mobile,
    this.place,
  });

  DealerModel copyWith({
    String? name,
    String? mobile,
    String? place,
  }) {
    return DealerModel(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      place: place ?? this.place,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'place': place,
    };
  }

  factory DealerModel.fromMap(Map<String, dynamic> map) {
    return DealerModel(
      name: map['name'],
      mobile: map['mobile'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerModel.fromJson(String source) => DealerModel.fromMap(json.decode(source));

  @override
  String toString() => 'DealerModel(name: $name, mobile: $mobile, place: $place)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DealerModel &&
      other.name == name &&
      other.mobile == mobile &&
      other.place == place;
  }

  @override
  int get hashCode => name.hashCode ^ mobile.hashCode ^ place.hashCode;
}
