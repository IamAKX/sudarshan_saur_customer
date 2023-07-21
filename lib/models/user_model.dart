import 'dart:convert';

import 'package:saur_customer/models/address_model.dart';

class UserModel {
  int? id;
  String? customerName;
  String? password;
  String? mobileNo;
  String? status;
  String? email;
  AddressModel? address;
  String? image;
  String? lastLogin;
  String? lastPurchaseDate;
  UserModel({
    this.id,
    this.customerName,
    this.password,
    this.mobileNo,
    this.status,
    this.email,
    this.address,
    this.image,
    this.lastLogin,
    this.lastPurchaseDate,
  });

  UserModel copyWith({
    int? id,
    String? customerName,
    String? password,
    String? mobileNo,
    String? status,
    String? email,
    AddressModel? address,
    String? image,
    String? lastLogin,
    String? lastPurchaseDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      password: password ?? this.password,
      mobileNo: mobileNo ?? this.mobileNo,
      status: status ?? this.status,
      email: email ?? this.email,
      address: address ?? this.address,
      image: image ?? this.image,
      lastLogin: lastLogin ?? this.lastLogin,
      lastPurchaseDate: lastPurchaseDate ?? this.lastPurchaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'password': password,
      'mobileNo': mobileNo,
      'status': status,
      'email': email,
      'address': address?.toMap(),
      'image': image,
      'lastLogin': lastLogin,
      'lastPurchaseDate': lastPurchaseDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      customerName: map['customerName'],
      password: map['password'],
      mobileNo: map['mobileNo'],
      status: map['status'],
      email: map['email'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      image: map['image'],
      lastLogin: map['lastLogin'],
      lastPurchaseDate: map['lastPurchaseDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, customerName: $customerName, password: $password, mobileNo: $mobileNo, status: $status, email: $email, address: $address, image: $image, lastLogin: $lastLogin, lastPurchaseDate: $lastPurchaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.customerName == customerName &&
        other.password == password &&
        other.mobileNo == mobileNo &&
        other.status == status &&
        other.email == email &&
        other.address == address &&
        other.image == image &&
        other.lastLogin == lastLogin &&
        other.lastPurchaseDate == lastPurchaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerName.hashCode ^
        password.hashCode ^
        mobileNo.hashCode ^
        status.hashCode ^
        email.hashCode ^
        address.hashCode ^
        image.hashCode ^
        lastLogin.hashCode ^
        lastPurchaseDate.hashCode;
  }
}
