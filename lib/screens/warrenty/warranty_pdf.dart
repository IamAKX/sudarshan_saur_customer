import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/preference_key.dart';

Future<String> makePdf(WarrantyRequestModel? warranty) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/guarantee_logo.png'))
          .buffer
          .asUint8List());

  final tnc1Img = MemoryImage(
      (await rootBundle.load('assets/images/Pictureall.png'))
          .buffer
          .asUint8List());
  final tnc2Img = MemoryImage(
      (await rootBundle.load('assets/images/tnc2.png')).buffer.asUint8List());
  final tnc3Img = MemoryImage(
      (await rootBundle.load('assets/images/tnc3.png')).buffer.asUint8List());
  UserModel? userModel =
      await ApiProvider().getCustomerById(SharedpreferenceKey.getUserId());

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return warrantyContext(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc2(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc3(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc4(imageLogo, warranty!, userModel); // Center
      },
    ),
  ); // Page

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.portrait,
      margin: const EdgeInsets.all(defaultPadding),
      build: (Context context) {
        return tnc5(tnc1Img, tnc2Img, tnc3Img, warranty!, userModel); // Center
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
        rowItem('OTP Session ID:',
            prefs.getString(SharedpreferenceKey.otpMessageId) ?? '-'),
        divider(),
        rowItem('OTP Time:',
            prefs.getString(SharedpreferenceKey.otpMessageTime) ?? '-'),
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
            style: const TextStyle(
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
                    style: const TextStyle(
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
                    style: const TextStyle(
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
            style: const TextStyle(
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
          padding: const EdgeInsets.all(5),
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
          padding: const EdgeInsets.all(5),
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
          padding: const EdgeInsets.all(5),
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
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(5),
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
        rowItemTnC('17',
            'Cleaning of scales of deposits inside the evacuated tube & Flat plate collector absorber is not covered under Guarantee*.'),
        tncdivider(),
        rowItemTnC('18',
            'If solar water heater which, during the Guarantee* period either, has been shifted from one location to another or changed ownership by sale or lease, gift or otherwise, without written intimation to that effect being given to the company within seven days of such shifting or change of ownership and, in the case of shifting, has not been installed in the new location as per instruction given in user manual or by one of the company\'s authorized dealers or technician at cost of the purchaser.'),
        tncdivider(),
        Row(
          children: [
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Text(
                '*',
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
                  'Guarantee* Terms and Conditions test ab',
                  style: TextStyle(
                    fontSize: 14,
                    color: PdfColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: pdfBorderColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        tncdivider(),
        rowItemTnC('1',
            'We agree to repair or if found necessary to replace any defective part. While the company and/or authorized dealer will make every effort to carry out repairs and/or replacements at the earliest, However it is made expressly clear that the company and/or authorized dealer is under no obligation to do so in specified period of time without any material/part charges to the user.'),
        tncdivider(),
        rowItemTnC('2',
            'The Guarantee* does not include transport, delivery, handling charges of defective and replaced items.'),
        tncdivider(),
        rowItemTnC('3',
            'The company reserves the right to decide whether the defective part is to be repaired or replaced but in no case dowe Guarantee* to replace the total system.'),
        tncdivider(),
        rowItemTnC('4',
            'Where ever failed component or solar water heater is replaced under Guarantee*: the balance of original Guarantee* period will remain in effect. The repaired/replaced part or solar water heater does not carry a new Guarantee*. The liability of Sudarshan Saur under this Guarantee* is limited to the Guarantee* obligations as provided for herein. Any liability for indirect or consequential loss or damages which may be suffered by the customer including, but not limited to, loss/ damage of data or programs, loss of use, loss of profits, loss of production, loss of physical assets, loss of revenues or business interruption, is therefore specifically excluded.'),
        tncdivider(),
        rowItemTnC('5',
            'Guarantee* for the solar water heater will be on prorata basis as per the following details. New hot water storage tank against replacement will be given on prorata Guarantee* at discounts on spare price list in force at that time, which is decided and finalized by Sudarshan Saur Shakti Pvt. Ltd. from time to time.'),
        tncdivider(),
        rowItemTnC('A',
            'For Evacuated tube collector based GL non pressurized model 15 Year* Pro rata calculation for replacement of the tank after proper inspection and permission.'),
        rowItemTnC('',
            'For 100 / 150 / 200 / 250 / 300 / 150CA# / 200CA# / 225CA# / 250CA# / 300CA# LPD 1St year to 7th year tank price free*, for 8th year 50% discount, for 9th year 40% discount, for 10th year 35% discount, for 11th year 30% discount, for 12th year 25% discount, for 13th year 20% discount, for 14th year 15% discount and for 15th year 10% discount to the standard spare price list. (# = Collector area)'),
        tncdivider(),
        rowItemTnC('B',
            'For Evacuated tube collector based GL non pressurized commercial model 10 Year* Pro rata calculation for replacement of the tank after proper inspection and permission.'),
        rowItemTnC('',
            'For 407 / 450 / 500 / 500 Gross / 550 Gross LPD 1St year to 5th year tank price free*, for 6th year 35% discount, for 7th year 30% discount, for 8th year 25% discount, for 9th year 20% discount, 10th year 10% discount to the standard spare price list.'),
        tncdivider(),
        rowItemTnC('C',
            'For Evacuated tube collector based GL pressurized model 5 Year* Pro rata calculation for replacement of the tank after proper inspection and permission.'),
      ],
    ),
  );
}

Container tnc3(MemoryImage imageLogo, WarrantyRequestModel warrantyRequestModel,
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
        rowItemTnC('',
            'For Evacuated tube collector based GL pressurized model 5 Year* Prorata calculation for replacement of the tank after proper inspection and permission. 1 to 30 month tank price free*, For 31 to 36 month 40% discount, for 37 to 42 month 30% discount, for 43 to 48 month 20% discount, for 49 to 54 month 10% discount and for 55 to 60 month 5% discount to the standard spare price list.'),
        tncdivider(),
        rowItemTnC('6',
            'Post pressurized (Pressure pump installed at non pressurized solar water heaters outlet) Evacuated tube collector based system should be install in series mode / combination and maximum working pressure for it should be 2.5 Kg/cm2.'),
        tncdivider(),
        rowItemTnC('7',
            'This Guarantee* is valid only if quality of the water supplied to this Sudarshan Saur product is as follows for the period of use:'),
        tncdivider(),
        rowItemTnC('A.',
            'Chloride hardness of water supplied should be less than 600 ppm and TDS must be less than 1500 ppm for Wonder Ultimate GL series.'),
        tncdivider(),
        rowItemTnC('B.',
            'PH value of water supplied to this solar water heating system should be 6.5 to 7.5.'),
        tncdivider(),
        rowItemTnC('C.',
            'The TDS value measured and recorded at time of sale are approximate and may vary during the course of use due to the depth, type of the water source. Hence the TDS measurement at the time of sale does not in any way bind Sudarshan Saur to support this Guarantee*, if the above criteria in clause 7(A&B), is not met during the period of use. However as per BIS, more than 500 PPM hardness of water is not recommended for bathing.'),
        tncdivider(),
        rowItemTnC('8',
            'Service charges will be applicable after 1(One) Year. Further if company technician / Dealer finds no merit in the complaints then customer has to pay service charges.'),
        tncdivider(),
        rowItemTnC('9',
            'The company employees, dealers and service contractors have no authority to alter the terms of this Guarantee*.'),
        tncdivider(),
        rowItemTnC('10',
            'Service charges would be applicable in case of non-standard installation and/ or where the system is installed on a slope roof / fabricated structure or in a place difficult to access the system. The service charges applicable would be extra at actual, payable by the customer.'),
        tncdivider(),
        rowItemTnC('11',
            'This Guarantee* shall not cover any consequential or resulting liability, damage or loss to property or life arising directly or indirectly out of any defect or improper use of/in the solar water heating system. The company\'s obligation under this Guarantee* shall be limited to repair or providing replacement of defective parts only within the Guarantee* period.'),
        tncdivider(),
        rowItemTnC('12',
            'Maximum liability of the system installed and failed to perform shall not be more than the cost of the failed part of the individual system, whether or not installed in series or parallel.'),
        tncdivider(),
        rowItemTnC('13',
            'The company reserves the right to retain any part/s or components at its discretion, in the event of a defect being noticed in the equipment during Guarantee* period.'),
        tncdivider(),
        rowItemTnC('14',
            'This Guarantee* will automatically terminate on the expiry of the Guarantee* period, even if the solar water heating system may not be in use for any time during the Guarantee* period for any reason.'),
        tncdivider(),
        rowItemTnC('15',
            'In case of doubts in interpretation of the terms of Guarantee* or the mode of redressal of these complaints, the purchaser is required to seek such clarification in writing from the company. The decision of the company is final in all such cases of complaints.'),
        tncdivider(),
        rowItemTnC('16',
            'All disputes shall be subject to Chhatrapati Sambhajinagar (Aurangabad), Maharashtra Jurisdiction only.'),
        tncdivider(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(5),
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

Container tnc4(MemoryImage imageLogo, WarrantyRequestModel warrantyRequestModel,
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
        rowItemTnC('19',
            'This Guarantee* will automatically terminate on the expiry of the Guarantee period, even if the solar water heating system may not be in use for any time during the Guarantee period for any reason.'),
        tncdivider(),
        rowItemTnC('20',
            'In case of doubts in interpretation of the terms of Guarantee* or the mode of redressal of these complaints, the purchaser is required To seek such clarification in writing from the company. The decision of the company is final in all such cases of complaints.'),
        tncdivider(),
        rowItemTnC('21',
            'Sudarshan saur is liable or responcible for complaints, which are communicated in wrritten on our customer care Email ID. (customercare@sudarshansaur.com)'),
        tncdivider(),
        rowItemTnC('22',
            'All disputes shall be subject to Aurangabad Jurisdiction only.'),
        tncdivider(),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Performance Of Solar Water Heating System In (Winter) Cold Climate Season.',
            style: TextStyle(
              fontSize: 14,
              color: PdfColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'As you very well aware that the solar water heater absorbs the heat from the sunlight and transfers this heat to the water & make it hot. The input energy to heat the water is sunlight which we receive from sun and as you know, intensity of the sunlight changes during the year with-respect to change in season. So we request to you all to understand that the performance of solar water heater is depending upon many parameters as given below. 1)  Capacity  of  Solar  Water  Heating  System  with  respect  to  the number of users. 2) Capacity of Solar Water Heating System  with respect to water used by the number of user. 3) The hot water used for Bathing / Washing hands and legs during last night . 4) Intensity of Solar Rays. 5) The temperature of cold water entering in hot water solar tank. 6) Continues Drop leakage from solar water tank. 7) Failure of hot & cold water mixer causing entering the cold water in the hot water tank from    outlet side due to gravity and height of cold  water  tank.  8)  Improper  Cold  Water  Pipeline  (Do  it  as  per sticker given on solar tank). So from above  given detailing,  it is  very much clear to you , that the  effectiveness  of  solar  water  heating  system  is  much  more related to the intensity of heat present in sunlight and performance of solar water heater is also related with various points given above which should be taken care by the customer. We hope that you will understand us , be with us and will enjoy the hot water from solar water heating systems for the clean & healthy life.',
            style: const TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(5),
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

Container tnc5(MemoryImage tnc1img, MemoryImage tnc2img, MemoryImage tnc3img,
    WarrantyRequestModel warrantyRequestModel, UserModel? userModel) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: PdfColors.white,
      border: Border.all(color: pdfBorderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'IMPORATANT PRECAUTIONS',
          style: TextStyle(
            fontSize: 14,
            color: PdfColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        tncdivider(),
        Expanded(
          child: Image(
            tnc1img,
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
            style: const TextStyle(fontSize: 12, color: PdfColors.black),
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
