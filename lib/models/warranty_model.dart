import 'dart:convert';

class WarrantyModel {
  String? warrantySerialNo;
  String? crmCustomerName;
  String? crmCustomerMobileNo;
  String? itemDescription;
  String? installationDate;
  String? model;
  String? guaranteeStatus;
  String? guaranteePeriod;
  String? assignedTo;
  String? custBillDate;
  String? billNo;
  String? invoiceNo;
  String? crmDealerName;
  String? crmStockistName;
  String? crmStockistMobileNo;
  String? crmStockistEmail;
  String? state;
  String? description;
  String? stockists;
  String? customer;
  String? allocationStatus;
  String? createdOn;
  String? updatedOn;
  String? initUserType;
  String? initiatedBy;
  String? approvedBy;
  String? lpd;
  WarrantyModel({
    this.warrantySerialNo,
    this.crmCustomerName,
    this.crmCustomerMobileNo,
    this.itemDescription,
    this.installationDate,
    this.model,
    this.guaranteeStatus,
    this.guaranteePeriod,
    this.assignedTo,
    this.custBillDate,
    this.billNo,
    this.invoiceNo,
    this.crmDealerName,
    this.crmStockistName,
    this.crmStockistMobileNo,
    this.crmStockistEmail,
    this.state,
    this.description,
    this.stockists,
    this.customer,
    this.allocationStatus,
    this.createdOn,
    this.updatedOn,
    this.initUserType,
    this.initiatedBy,
    this.approvedBy,
    this.lpd,
  });

  WarrantyModel copyWith({
    String? warrantySerialNo,
    String? crmCustomerName,
    String? crmCustomerMobileNo,
    String? itemDescription,
    String? installationDate,
    String? model,
    String? guaranteeStatus,
    String? guaranteePeriod,
    String? assignedTo,
    String? custBillDate,
    String? billNo,
    String? invoiceNo,
    String? crmDealerName,
    String? crmStockistName,
    String? crmStockistMobileNo,
    String? crmStockistEmail,
    String? state,
    String? description,
    String? stockists,
    String? customer,
    String? allocationStatus,
    String? createdOn,
    String? updatedOn,
    String? initUserType,
    String? initiatedBy,
    String? approvedBy,
    String? lpd,
  }) {
    return WarrantyModel(
      warrantySerialNo: warrantySerialNo ?? this.warrantySerialNo,
      crmCustomerName: crmCustomerName ?? this.crmCustomerName,
      crmCustomerMobileNo: crmCustomerMobileNo ?? this.crmCustomerMobileNo,
      itemDescription: itemDescription ?? this.itemDescription,
      installationDate: installationDate ?? this.installationDate,
      model: model ?? this.model,
      guaranteeStatus: guaranteeStatus ?? this.guaranteeStatus,
      guaranteePeriod: guaranteePeriod ?? this.guaranteePeriod,
      assignedTo: assignedTo ?? this.assignedTo,
      custBillDate: custBillDate ?? this.custBillDate,
      billNo: billNo ?? this.billNo,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      crmDealerName: crmDealerName ?? this.crmDealerName,
      crmStockistName: crmStockistName ?? this.crmStockistName,
      crmStockistMobileNo: crmStockistMobileNo ?? this.crmStockistMobileNo,
      crmStockistEmail: crmStockistEmail ?? this.crmStockistEmail,
      state: state ?? this.state,
      description: description ?? this.description,
      stockists: stockists ?? this.stockists,
      customer: customer ?? this.customer,
      allocationStatus: allocationStatus ?? this.allocationStatus,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      initUserType: initUserType ?? this.initUserType,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      lpd: lpd ?? this.lpd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'warrantySerialNo': warrantySerialNo,
      'crmCustomerName': crmCustomerName,
      'crmCustomerMobileNo': crmCustomerMobileNo,
      'itemDescription': itemDescription,
      'installationDate': installationDate,
      'model': model,
      'guaranteeStatus': guaranteeStatus,
      'guaranteePeriod': guaranteePeriod,
      'assignedTo': assignedTo,
      'custBillDate': custBillDate,
      'billNo': billNo,
      'invoiceNo': invoiceNo,
      'crmDealerName': crmDealerName,
      'crmStockistName': crmStockistName,
      'crmStockistMobileNo': crmStockistMobileNo,
      'crmStockistEmail': crmStockistEmail,
      'state': state,
      'description': description,
      'stockists': stockists,
      'customer': customer,
      'allocationStatus': allocationStatus,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'initUserType': initUserType,
      'initiatedBy': initiatedBy,
      'approvedBy': approvedBy,
      'lpd': lpd,
    };
  }

  factory WarrantyModel.fromMap(Map<String, dynamic> map) {
    return WarrantyModel(
      warrantySerialNo: map['warrantySerialNo'],
      crmCustomerName: map['crmCustomerName'],
      crmCustomerMobileNo: map['crmCustomerMobileNo'],
      itemDescription: map['itemDescription'],
      installationDate: map['installationDate'],
      model: map['model'],
      guaranteeStatus: map['guaranteeStatus'],
      guaranteePeriod: map['guaranteePeriod'],
      assignedTo: map['assignedTo'],
      custBillDate: map['custBillDate'],
      billNo: map['billNo'],
      invoiceNo: map['invoiceNo'],
      crmDealerName: map['crmDealerName'],
      crmStockistName: map['crmStockistName'],
      crmStockistMobileNo: map['crmStockistMobileNo'],
      crmStockistEmail: map['crmStockistEmail'],
      state: map['state'],
      description: map['description'],
      stockists: map['stockists'],
      customer: map['customer'],
      allocationStatus: map['allocationStatus'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      initUserType: map['initUserType'],
      initiatedBy: map['initiatedBy'],
      approvedBy: map['approvedBy'],
      lpd: map['lpd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyModel.fromJson(String source) =>
      WarrantyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyModel(warrantySerialNo: $warrantySerialNo, crmCustomerName: $crmCustomerName, crmCustomerMobileNo: $crmCustomerMobileNo, itemDescription: $itemDescription, installationDate: $installationDate, model: $model, guaranteeStatus: $guaranteeStatus, guaranteePeriod: $guaranteePeriod, assignedTo: $assignedTo, custBillDate: $custBillDate, billNo: $billNo, invoiceNo: $invoiceNo, crmDealerName: $crmDealerName, crmStockistName: $crmStockistName, crmStockistMobileNo: $crmStockistMobileNo, crmStockistEmail: $crmStockistEmail, state: $state, description: $description, stockists: $stockists, customer: $customer, allocationStatus: $allocationStatus, createdOn: $createdOn, updatedOn: $updatedOn, initUserType: $initUserType, initiatedBy: $initiatedBy, approvedBy: $approvedBy, lpd: $lpd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyModel &&
        other.warrantySerialNo == warrantySerialNo &&
        other.crmCustomerName == crmCustomerName &&
        other.crmCustomerMobileNo == crmCustomerMobileNo &&
        other.itemDescription == itemDescription &&
        other.installationDate == installationDate &&
        other.model == model &&
        other.guaranteeStatus == guaranteeStatus &&
        other.guaranteePeriod == guaranteePeriod &&
        other.assignedTo == assignedTo &&
        other.custBillDate == custBillDate &&
        other.billNo == billNo &&
        other.invoiceNo == invoiceNo &&
        other.crmDealerName == crmDealerName &&
        other.crmStockistName == crmStockistName &&
        other.crmStockistMobileNo == crmStockistMobileNo &&
        other.crmStockistEmail == crmStockistEmail &&
        other.state == state &&
        other.description == description &&
        other.stockists == stockists &&
        other.customer == customer &&
        other.allocationStatus == allocationStatus &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.initUserType == initUserType &&
        other.initiatedBy == initiatedBy &&
        other.approvedBy == approvedBy &&
        other.lpd == lpd;
  }

  @override
  int get hashCode {
    return warrantySerialNo.hashCode ^
        crmCustomerName.hashCode ^
        crmCustomerMobileNo.hashCode ^
        itemDescription.hashCode ^
        installationDate.hashCode ^
        model.hashCode ^
        guaranteeStatus.hashCode ^
        guaranteePeriod.hashCode ^
        assignedTo.hashCode ^
        custBillDate.hashCode ^
        billNo.hashCode ^
        invoiceNo.hashCode ^
        crmDealerName.hashCode ^
        crmStockistName.hashCode ^
        crmStockistMobileNo.hashCode ^
        crmStockistEmail.hashCode ^
        state.hashCode ^
        description.hashCode ^
        stockists.hashCode ^
        customer.hashCode ^
        allocationStatus.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        initUserType.hashCode ^
        initiatedBy.hashCode ^
        approvedBy.hashCode ^
        lpd.hashCode;
  }
}
