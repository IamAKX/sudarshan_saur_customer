import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';

import '../../services/api_service.dart';
import '../../utils/preference_key.dart';

makePdf(WarrantyModel? warranty) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/logo/warranty_branding.png'))
          .buffer
          .asUint8List());
  UserModel? userModel =
      await ApiProvider().getCustomerById(SharedpreferenceKey.getUserId());

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.landscape,
      build: (Context context) {
        return Center(
          child: Stack(children: [
            Center(
              child: Text(
                'Sudarshan Saur',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.grey200),
              ),
            ),
            warrantyContext(imageLogo, warranty, userModel),
          ]),
        ); // Center
      },
    ),
  ); // Page

  return writeFile(pdf.save(), warranty?.warrantySerialNo ?? '');
}

Container warrantyContext(
    MemoryImage imageLogo, WarrantyModel? warranty, UserModel? userModel) {
  return Container(
    height: double.maxFinite,
    width: double.infinity,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(
              'WARRANTY CERTIFICATE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
            warrantyRowItem('Customer name', '${userModel?.customerName}'),
            warrantyRowItem(
                'Customer address', prepareAddress(userModel?.address)),
            // warrantyRowItem(
            //     'Dealer name', '${warranty?.stockists?.stockistName}'),
            warrantyRowItem('Dealer Address', '${warranty?.state}'),
            warrantyRowItem('System/Model Rating',
                '${warranty?.lpd} ${warranty?.model} ${warranty?.itemDescription}'),
            warrantyRowItem('Sr. No', '${warranty?.warrantySerialNo}'),
            warrantyRowItem(
                'Date',
                DateTimeFormatter.onlyDateShort(
                    warranty?.installationDate ?? '')),
            warrantyRowItem('Invoice No', '${warranty?.invoiceNo}'),
            SizedBox(
              height: defaultPadding,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'We here by confirm that your Sudarshan Saur Solar Water Heater System\nis guaranteed for the period mentioned from the date of the invoice.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dealer Stamp',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: PdfColors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '* Condition apply',
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Image(imageLogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

warrantyRowItem(String key, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          key,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}

writeFile(Future<Uint8List> save, String slNo) async {
  String filePath = '';
  if (Platform.isIOS) {
    await getApplicationDocumentsDirectory().then((dir) => filePath = dir.path);
  } else {
    filePath = '/storage/emulated/0/Download';
  }
  filePath += '/warranty_$slNo.pdf';

  final file = File(filePath);
  save.then((value) async {
    await file.writeAsBytes(value);
  });
}
