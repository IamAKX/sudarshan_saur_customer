import 'dart:convert';

class TechnicianModel {
  String? name;
  String? mobile;
  String? place;
  TechnicianModel({
    this.name,
    this.mobile,
    this.place,
  });

  TechnicianModel copyWith({
    String? name,
    String? mobile,
    String? place,
  }) {
    return TechnicianModel(
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

  factory TechnicianModel.fromMap(Map<String, dynamic> map) {
    return TechnicianModel(
      name: map['name'],
      mobile: map['mobile'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TechnicianModel.fromJson(String source) => TechnicianModel.fromMap(json.decode(source));

  @override
  String toString() => 'DealerModel(name: $name, mobile: $mobile, place: $place)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TechnicianModel &&
      other.name == name &&
      other.mobile == mobile &&
      other.place == place;
  }

  @override
  int get hashCode => name.hashCode ^ mobile.hashCode ^ place.hashCode;
}
