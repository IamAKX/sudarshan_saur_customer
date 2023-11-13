import 'dart:convert';

class PlumberModel {
  String? name;
  String? mobile;
  String? place;
  PlumberModel({
    this.name,
    this.mobile,
    this.place,
  });

  PlumberModel copyWith({
    String? name,
    String? mobile,
    String? place,
  }) {
    return PlumberModel(
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

  factory PlumberModel.fromMap(Map<String, dynamic> map) {
    return PlumberModel(
      name: map['name'],
      mobile: map['mobile'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlumberModel.fromJson(String source) => PlumberModel.fromMap(json.decode(source));

  @override
  String toString() => 'DealerModel(name: $name, mobile: $mobile, place: $place)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PlumberModel &&
      other.name == name &&
      other.mobile == mobile &&
      other.place == place;
  }

  @override
  int get hashCode => name.hashCode ^ mobile.hashCode ^ place.hashCode;
}
