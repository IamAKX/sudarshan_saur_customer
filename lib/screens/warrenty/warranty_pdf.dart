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
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc2(imageLogo, warranty!, userModel); // Center
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

Container tnc(MemoryImage imageLogo, WarrantyRequestModel warrantyRequestModel,
    UserModel? userModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: PdfColors.white,
      border: Border.all(color: pdfBorderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "We hereby confirm that your Sudarshan Saur Solar Water Heating System is Guaranteed for the period mentioned, from the date of the invoice on pro‐rata basis.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        tncdivider(),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Guarantee Exclusions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        tncdivider(),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Repair and replacement work will be carried out as set, but following terms and exclusions may cause the solar water heater Guarantee* to become VOID and may incur a service charge and cost of part/s if any.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        tncdivider(),
        rowItemTnC('1',
            'If the completed Guarantee* card not presented to the company or authorized dealer/technician at the time of testing, repair or servicing.'),
        tncdivider(),
        rowItemTnC('2',
            'If the system is not installed, operated, maintained as per the guidelines given in the user manual.'),
        tncdivider(),
        rowItemTnC('3',
            'If the system parts repaired altered or shifted from other unauthorized agencies without company\'s official permission.'),
        tncdivider(),
        rowItemTnC('4',
            'If the original serial number is deleted, defaced or altered.'),
        tncdivider(),
        rowItemTnC('5', 'If none clearing of any payment.'),
        tncdivider(),
        rowItemTnC(
            '6', 'Breakage of Vacuum Tube & Toughned glass due to any reason.'),
        tncdivider(),
        rowItemTnC('7',
            'Defects or faults which in the opinion of the company is due to misuse or neglect or accident, acts of god like cyclone, heavy winds, hail stones, heavy rainfall, earthquakes, fire, lightning etc.'),
        tncdivider(),
        rowItemTnC('8',
            'Damages resulting from exceeding the maximum permissible inlet water pressure 0.3kg/cm2 for non pressurized system and 4kg/cm2 in case of pressurized system.'),
        tncdivider(),
        rowItemTnC('9',
            'Damages due to improper selection of accessories external to the original equipment and/or Improper selection of model/ capacity or misuse of any kind.'),
        tncdivider(),
        rowItemTnC('10',
            'Improper performance of system or any other damage due to salts and scaling occurred because of hard water/ Algae.'),
        tncdivider(),
        rowItemTnC('11',
            'Minor scratch or distortion occurred during transport, loading, unloading or installation of system and normal wear and tear of various parts.'),
        tncdivider(),
        rowItemTnC('12',
            'Various components like rubber parts, plastic parts, air relief valve, electrical heater etc, that are bought from outside. Accessories external to the original equipment.'),
        tncdivider(),
        rowItemTnC('13',
            'Effect on exterior surface coating due to weathering, rain or sunshine etc.or drops from the air vent.'),
        tncdivider(),
        rowItemTnC('14',
            'Heat loss resulting from not insulating the air vent, out let pipeline and extra length of hot water pipeline and very cold water supplied to the system.'),
        tncdivider(),
        rowItemTnC('15',
            'No fixed temperature Guarantee* can be given for hot water generated by this Sudarshan Saur product, as the heating of water depends on solar radiation fluctuations OR geo‐climatic conditions.'),
        tncdivider(),
        rowItemTnC('16',
            'In no event shall the company be liable to a user for any special, incidental or consequential loss or damage; any such claims are specially excluded under this Guarantee* certificate.'),
        tncdivider(),
        rowItemTnC('17',
            'Cleaning of scales of deposits inside the evacuated tube & Flat plate collector absorber is not covered under Guarantee*.'),
      ],
    ),
  );
}

Container tnc2(MemoryImage imageLogo, WarrantyRequestModel warrantyRequestModel,
    UserModel? userModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: PdfColors.white,
      border: Border.all(color: pdfBorderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowItemTnC('18',
            'If solar water heater which, during the Guarantee* period either, has been shifted from one location to another or changed ownership by sale or lease, gift or otherwise, without written intimation to that effect being given to the company within seven days of such shifting or change of ownership and, in the case of shifting, has not been installed in the new location as per instruction given in user manual or by one of the company\'s authorized dealers or technician at cost of the purchaser.'),
        tncdivider(),
        Spacer(),
        tncdivider(),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "*Conditions apply",
            style: const TextStyle(
              fontSize: 12,
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
Divider tncdivider() => Divider(
      color: pdfBorderColor,
      thickness: 1,
      height: 1,
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

Row rowItemTnC(String key, String value) => Row(
      children: [
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: PdfColors.black),
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: pdfBorderColor),
              ),
            ),
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
