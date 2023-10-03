import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';

import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/preference_key.dart';

Future<String> makePdf(WarrantyRequestModel? warranty) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/guarantee_logo.png'))
          .buffer
          .asUint8List());
  UserModel? userModel =
      await ApiProvider().getCustomerById(SharedpreferenceKey.getUserId());

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return warrantyContext(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  return writeFile(
      pdf.save(), warranty?.warrantyDetails?.warrantySerialNo ?? '');
}

Container warrantyContext(MemoryImage imageLogo,
    WarrantyRequestModel warrantyRequestModel, UserModel? userModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: PdfColors.white,
      border: Border.all(color: pdfBorderColor),
    ),
    child: Column(
      children: [
        Text(
          'GUARANTEE CARD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        divider(),
        rowItem('Customer Name:',
            warrantyRequestModel.customers?.customerName ?? ''),
        divider(),
        rowItem('Address:',
            prepareAddress(warrantyRequestModel.installationAddress)),
        divider(),
        rowItem('Landmark:',
            warrantyRequestModel.installationAddress?.landmark ?? ''),
        divider(),
        rowItem(
            'State:', warrantyRequestModel.installationAddress?.state ?? ''),
        divider(),
        rowItem('District:',
            warrantyRequestModel.installationAddress?.district ?? ''),
        divider(),
        rowItem(
            'Taluka:', warrantyRequestModel.installationAddress?.taluk ?? ''),
        divider(),
        rowItem('Mobile No:', warrantyRequestModel.customers?.mobileNo ?? ''),
        divider(),
        rowItem('Mobile No:', warrantyRequestModel.mobile2 ?? ''),
        divider(),
        rowItem('Dealer Name:', warrantyRequestModel.dealerInfo?.name ?? ''),
        divider(),
        rowItem(
            'Dealer Mobile No:', warrantyRequestModel.dealerInfo?.mobile ?? ''),
        divider(),
        rowItem('System Info:',
            warrantyRequestModel.warrantyDetails?.itemDescription ?? ''),
        divider(),
        rowItem('System Sr. No:',
            warrantyRequestModel.warrantyDetails?.warrantySerialNo ?? ''),
        divider(),
        rowItem('Company Invoice No:',
            warrantyRequestModel.warrantyDetails?.invoiceNo ?? ''),
        divider(),
        rowItem(
            'Company Invoice Date:',
            DateTimeFormatter.guaranteeCardDate(
                warrantyRequestModel.warrantyDetails?.installationDate ?? '')),
        divider(),
        rowItem(
            'Installation Date:', warrantyRequestModel.installationDate ?? ''),
        divider(),
        rowItem('Guarantee* Years:',
            warrantyRequestModel.warrantyDetails?.guaranteePeriod ?? ''),
        divider(),
        Text(
          '*Conditions apply.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Customer Care contact  details:- 7770066008 / 9225309153',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Email ID - customercare@sudarshansaur.com',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Constants.guaranteeCardMsg,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 8,
            ),
          ),
        ),
        divider(),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(height: 40),
                  Text(
                    'Customer Sign',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: Image(imageLogo),
                  ),
                  Text(
                    'Company Stamp',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'This is electronically generated Guarantee card and does not require any signature and stamp.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

PdfColor pdfBorderColor = PdfColors.purple;
Divider divider() => Divider(
      color: pdfBorderColor,
    );
Row rowItem(String key, String value) => Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: PdfColors.black),
          ),
        ),
      ],
    );

Future<String> writeFile(Future<Uint8List> save, String slNo) async {
  String filePath = '';
  if (Platform.isIOS) {
    await getApplicationDocumentsDirectory().then((dir) => filePath = dir.path);
  } else {
    filePath = '/storage/emulated/0/Download';
  }
  filePath += '/Guarantee_Card_$slNo.pdf';

  final file = File(filePath);
  await save.then((value) async {
    await file.writeAsBytes(value);
  });
  return filePath;
}
