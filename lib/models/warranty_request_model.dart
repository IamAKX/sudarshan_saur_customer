import 'dart:convert';

import 'package:saur_customer/models/dealer_model.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';

class WarrantyRequestModel {
  int? requestId;
  WarrantyModel? warrantyDetails;
  String? allocationStatus;
  DealerModel? dealers;
  UserModel? customers;
  String? createdOn;
  String? updatedOn;
  String? initUserType;
  String? initiatedBy;
  String? approvedBy;
  WarrantyRequestModel({
    this.requestId,
    this.warrantyDetails,
    this.allocationStatus,
    this.dealers,
    this.customers,
    this.createdOn,
    this.updatedOn,
    this.initUserType,
    this.initiatedBy,
    this.approvedBy,
  });

  WarrantyRequestModel copyWith({
    int? requestId,
    WarrantyModel? warrantyDetails,
    String? allocationStatus,
    DealerModel? dealers,
    UserModel? customers,
    String? createdOn,
    String? updatedOn,
    String? initUserType,
    String? initiatedBy,
    String? approvedBy,
  }) {
    return WarrantyRequestModel(
      requestId: requestId ?? this.requestId,
      warrantyDetails: warrantyDetails ?? this.warrantyDetails,
      allocationStatus: allocationStatus ?? this.allocationStatus,
      dealers: dealers ?? this.dealers,
      customers: customers ?? this.customers,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      initUserType: initUserType ?? this.initUserType,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      approvedBy: approvedBy ?? this.approvedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'warrantyDetails': warrantyDetails?.toMap(),
      'allocationStatus': allocationStatus,
      'dealers': dealers?.toMap(),
      'customers': customers?.toMap(),
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'initUserType': initUserType,
      'initiatedBy': initiatedBy,
      'approvedBy': approvedBy,
    };
  }

  factory WarrantyRequestModel.fromMap(Map<String, dynamic> map) {
    return WarrantyRequestModel(
      requestId: map['requestId']?.toInt(),
      warrantyDetails: map['warrantyDetails'] != null
          ? WarrantyModel.fromMap(map['warrantyDetails'])
          : null,
      allocationStatus: map['allocationStatus'],
      dealers:
          map['dealers'] != null ? DealerModel.fromMap(map['dealers']) : null,
      customers:
          map['customers'] != null ? UserModel.fromMap(map['customers']) : null,
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      initUserType: map['initUserType'],
      initiatedBy: map['initiatedBy'],
      approvedBy: map['approvedBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyRequestModel.fromJson(String source) =>
      WarrantyRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyRequestModel(requestId: $requestId, warrantyDetails: $warrantyDetails, allocationStatus: $allocationStatus, dealers: $dealers, customers: $customers, createdOn: $createdOn, updatedOn: $updatedOn, initUserType: $initUserType, initiatedBy: $initiatedBy, approvedBy: $approvedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyRequestModel &&
        other.requestId == requestId &&
        other.warrantyDetails == warrantyDetails &&
        other.allocationStatus == allocationStatus &&
        other.dealers == dealers &&
        other.customers == customers &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.initUserType == initUserType &&
        other.initiatedBy == initiatedBy &&
        other.approvedBy == approvedBy;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        warrantyDetails.hashCode ^
        allocationStatus.hashCode ^
        dealers.hashCode ^
        customers.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        initUserType.hashCode ^
        initiatedBy.hashCode ^
        approvedBy.hashCode;
  }
}
