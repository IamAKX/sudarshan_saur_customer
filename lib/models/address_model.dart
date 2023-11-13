import 'dart:convert';

class AddressModel {
  String? houseNo;
  String? area;
  String? street1;
  String? street2;
  String? landmark;
  String? town;
  String? taluk;
  String? state;
  String? country;
  String? zipCode;
  String? district;
  AddressModel({
    this.houseNo,
    this.area,
    this.street1,
    this.street2,
    this.landmark,
    this.town,
    this.taluk,
    this.state,
    this.country,
    this.zipCode,
    this.district,
  });

  AddressModel copyWith({
    String? houseNo,
    String? area,
    String? street1,
    String? street2,
    String? landmark,
    String? town,
    String? taluk,
    String? state,
    String? country,
    String? zipCode,
    String? district,
  }) {
    return AddressModel(
      houseNo: houseNo ?? this.houseNo,
      area: area ?? this.area,
      street1: street1 ?? this.street1,
      street2: street2 ?? this.street2,
      landmark: landmark ?? this.landmark,
      town: town ?? this.town,
      taluk: taluk ?? this.taluk,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      district: district ?? this.district,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'houseNo': houseNo,
      'area': area,
      'street1': street1,
      'street2': street2,
      'landmark': landmark,
      'town': town,
      'taluk': taluk,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'district': district,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      houseNo: map['houseNo'],
      area: map['area'],
      street1: map['street1'],
      street2: map['street2'],
      landmark: map['landmark'],
      town: map['town'],
      taluk: map['taluk'],
      state: map['state'],
      country: map['country'],
      zipCode: map['zipCode'],
      district: map['district'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(houseNo: $houseNo, area: $area, street1: $street1, street2: $street2, landmark: $landmark, town: $town, taluk: $taluk, state: $state, country: $country, zipCode: $zipCode, district: $district)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressModel &&
      other.houseNo == houseNo &&
      other.area == area &&
      other.street1 == street1 &&
      other.street2 == street2 &&
      other.landmark == landmark &&
      other.town == town &&
      other.taluk == taluk &&
      other.state == state &&
      other.country == country &&
      other.zipCode == zipCode &&
      other.district == district;
  }

  @override
  int get hashCode {
    return houseNo.hashCode ^
      area.hashCode ^
      street1.hashCode ^
      street2.hashCode ^
      landmark.hashCode ^
      town.hashCode ^
      taluk.hashCode ^
      state.hashCode ^
      country.hashCode ^
      zipCode.hashCode ^
      district.hashCode;
  }
}
