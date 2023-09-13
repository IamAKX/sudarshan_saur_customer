import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show Color, rootBundle;
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../services/api_service.dart';
import '../../utils/preference_key.dart';

Future<String> makeCertificatePdf(WarrantyRequestModel? warranty) async {
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
      orientation: PageOrientation.landscape,
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
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            'INSTALLATION CERTIFICATE',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: PdfColors.black),
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          child: SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Solar Water Heating System',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalDivider(),
                Expanded(
                  child: Text(
                    'No:. ${warrantyRequestModel.warrantyDetails?.warrantySerialNo}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                verticalDivider(),
                Expanded(
                  child: Text(
                    'Date: ${DateTimeFormatter.onlyDateShort(warrantyRequestModel.warrantyDetails?.installationDate ?? '')}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        divider(),
        SizedBox(
          height: 20,
          child: Row(
            children: [
              Text(
                'Full Name of Client : ',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                warrantyRequestModel.customers?.customerName ?? '',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: pdfBackgroundColor,
                      child: Text(
                        'Installation Address',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    divider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        prepareAddress(
                            warrantyRequestModel.installationAddress),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: pdfBackgroundColor,
                      child: Text(
                        'Owner\'s Address',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    divider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        prepareAddress(warrantyRequestModel.ownerAddress),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        divider(),
        SizedBox(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Place: ${warrantyRequestModel.installationAddress?.area}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                            'Dist: ${warrantyRequestModel.installationAddress?.district}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Pin Code: ${warrantyRequestModel.installationAddress?.zipCode}'),
                      ),
                    ),
                  ],
                ),
              ),
              verticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Taluka: ${warrantyRequestModel.installationAddress?.taluk}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                            'State: ${warrantyRequestModel.installationAddress?.state}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Tel. No: ${warrantyRequestModel.customers?.mobileNo}'),
                      ),
                    ),
                  ],
                ),
              ),
              verticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'A/p: ${warrantyRequestModel.ownerAddress?.area}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                            'Dist: ${warrantyRequestModel.ownerAddress?.district}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Pin Code: ${warrantyRequestModel.ownerAddress?.zipCode}'),
                      ),
                    ),
                  ],
                ),
              ),
              verticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text(
                            'Taluka: ${warrantyRequestModel.ownerAddress?.taluk}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                            'State: ${warrantyRequestModel.ownerAddress?.state}'),
                      ),
                    ),
                    divider(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: pdfBackgroundColor,
                        child: Text('Tel. No: ${warrantyRequestModel.mobile2}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        divider(),
        SizedBox(
          height: 20,
          child: Row(
            children: [
              Text(
                'Sr.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                child: Text(
                  'Paticulars',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          height: 20,
          child: Row(
            children: [
              Text(
                ' 1 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'Company Invoice Ref. No',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.invoiceNumber ?? '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          height: 20,
          child: Row(
            children: [
              Text(
                ' 2 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'System Rating & Model',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  '${warrantyRequestModel.warrantyDetails?.lpd} LPD ${warrantyRequestModel.warrantyDetails?.model}',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          height: 20,
          child: Row(
            children: [
              Text(
                ' 3 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'System Serial No.',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.warrantyDetails?.warrantySerialNo ?? '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          height: 20,
          child: Row(
            children: [
              Text(
                ' 4 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'Application',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.answers
                          ?.firstWhere(
                              (element) => element.questions?.questionId == 2)
                          .answerText ??
                      '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          height: 20,
          child: Row(
            children: [
              Text(
                ' 5 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'Water Source',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.answers
                          ?.firstWhere(
                              (element) => element.questions?.questionId == 3)
                          .answerText ??
                      '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          height: 20,
          child: Row(
            children: [
              Text(
                ' 6 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'No of Using Point',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.answers
                          ?.firstWhere(
                              (element) => element.questions?.questionId == 6)
                          .answerText ??
                      '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          height: 20,
          child: Row(
            children: [
              Text(
                ' 7 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  'Total Length',
                  textAlign: TextAlign.left,
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Text(
                  warrantyRequestModel.answers
                          ?.firstWhere(
                              (element) => element.questions?.questionId == 9)
                          .answerText ??
                      '',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          alignment: Alignment.center,
          height: 30,
          child: Text(
            'We confirm that above said system is installed & working satisfactory',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        divider(),
        Container(
          color: pdfBackgroundColor,
          height: 100,
          child: Row(
            children: [
              Text('    '),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Customer Name & Sign :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '    ',
                    ),
                  ],
                ),
              ),
              verticalDivider(),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Image(imageLogo),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 20,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
              'This is electronically generated Guarantee card and does not require any signature and stamp.'),
        )
      ],
    ),
  );
}

PdfColor pdfBorderColor = PdfColor.fromHex('FF912C');
PdfColor pdfBackgroundColor = PdfColor.fromHex('FFE9D8');
// PdfColor pdfBorderColor = PdfColors.orangeAccent;
// PdfColor pdfBackgroundColor = PdfColors.orangeAccent100;
Divider divider() => Divider(
      color: pdfBorderColor,
      height: 2,
    );
VerticalDivider verticalDivider() => VerticalDivider(
      color: pdfBorderColor,
      width: 2,
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
  filePath += '/Installation_Certificate_$slNo.pdf';

  final file = File(filePath);
  await save.then((value) async {
    await file.writeAsBytes(value);
  });
  return filePath;
}

extension PdfColorExtension on PdfColor {
  PdfColor flattenWithBackground(PdfColor background) {
    return PdfColor(
      alpha * red + (1 - alpha) * background.red,
      alpha * green + (1 - alpha) * background.green,
      alpha * blue + (1 - alpha) * background.blue,
    );
  }
}
