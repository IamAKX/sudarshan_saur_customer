import 'dart:convert';

class WarrantyModel {
  String? warrantySerialNo;
  String? invoiceNo;
  String? itemDescription;
  String? model;
  String? installationDate;
  String? guranteePeriod;
  String? validTill;
  String? custBillDate;
  String? allocationStatus;
  String? billNo;
  String? subDealer;
  String? dealers;
  String? state;
  String? description;
  String? lpd;
  WarrantyModel({
    this.warrantySerialNo,
    this.invoiceNo,
    this.itemDescription,
    this.model,
    this.installationDate,
    this.guranteePeriod,
    this.validTill,
    this.custBillDate,
    this.allocationStatus,
    this.billNo,
    this.subDealer,
    this.dealers,
    this.state,
    this.description,
    this.lpd,
  });

  WarrantyModel copyWith({
    String? warrantySerialNo,
    String? invoiceNo,
    String? itemDescription,
    String? model,
    String? installationDate,
    String? guranteePeriod,
    String? validTill,
    String? custBillDate,
    String? allocationStatus,
    String? billNo,
    String? subDealer,
    String? dealers,
    String? state,
    String? description,
    String? lpd,
  }) {
    return WarrantyModel(
      warrantySerialNo: warrantySerialNo ?? this.warrantySerialNo,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      itemDescription: itemDescription ?? this.itemDescription,
      model: model ?? this.model,
      installationDate: installationDate ?? this.installationDate,
      guranteePeriod: guranteePeriod ?? this.guranteePeriod,
      validTill: validTill ?? this.validTill,
      custBillDate: custBillDate ?? this.custBillDate,
      allocationStatus: allocationStatus ?? this.allocationStatus,
      billNo: billNo ?? this.billNo,
      subDealer: subDealer ?? this.subDealer,
      dealers: dealers ?? this.dealers,
      state: state ?? this.state,
      description: description ?? this.description,
      lpd: lpd ?? this.lpd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'warrantySerialNo': warrantySerialNo,
      'invoiceNo': invoiceNo,
      'itemDescription': itemDescription,
      'model': model,
      'installationDate': installationDate,
      'guranteePeriod': guranteePeriod,
      'validTill': validTill,
      'custBillDate': custBillDate,
      'allocationStatus': allocationStatus,
      'billNo': billNo,
      'subDealer': subDealer,
      'dealers': dealers,
      'state': state,
      'description': description,
      'lpd': lpd,
    };
  }

  factory WarrantyModel.fromMap(Map<String, dynamic> map) {
    return WarrantyModel(
      warrantySerialNo: map['warrantySerialNo'],
      invoiceNo: map['invoiceNo'],
      itemDescription: map['itemDescription'],
      model: map['model'],
      installationDate: map['installationDate'],
      guranteePeriod: map['guranteePeriod'],
      validTill: map['validTill'],
      custBillDate: map['custBillDate'],
      allocationStatus: map['allocationStatus'],
      billNo: map['billNo'],
      subDealer: map['subDealer'],
      dealers: map['dealers'],
      state: map['state'],
      description: map['description'],
      lpd: map['lpd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyModel.fromJson(String source) =>
      WarrantyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyModel(warrantySerialNo: $warrantySerialNo, invoiceNo: $invoiceNo, itemDescription: $itemDescription, model: $model, installationDate: $installationDate, guranteePeriod: $guranteePeriod, validTill: $validTill, custBillDate: $custBillDate, allocationStatus: $allocationStatus, billNo: $billNo, subDealer: $subDealer, dealers: $dealers, state: $state, description: $description, lpd: $lpd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyModel &&
        other.warrantySerialNo == warrantySerialNo &&
        other.invoiceNo == invoiceNo &&
        other.itemDescription == itemDescription &&
        other.model == model &&
        other.installationDate == installationDate &&
        other.guranteePeriod == guranteePeriod &&
        other.validTill == validTill &&
        other.custBillDate == custBillDate &&
        other.allocationStatus == allocationStatus &&
        other.billNo == billNo &&
        other.subDealer == subDealer &&
        other.dealers == dealers &&
        other.state == state &&
        other.description == description &&
        other.lpd == lpd;
  }

  @override
  int get hashCode {
    return warrantySerialNo.hashCode ^
        invoiceNo.hashCode ^
        itemDescription.hashCode ^
        model.hashCode ^
        installationDate.hashCode ^
        guranteePeriod.hashCode ^
        validTill.hashCode ^
        custBillDate.hashCode ^
        allocationStatus.hashCode ^
        billNo.hashCode ^
        subDealer.hashCode ^
        dealers.hashCode ^
        state.hashCode ^
        description.hashCode ^
        lpd.hashCode;
  }
}
