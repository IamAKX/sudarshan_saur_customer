import 'package:flutter/material.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/warrenty/certificate_pdf.dart';
import 'package:saur_customer/utils/constants.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

class PdfDummy extends StatefulWidget {
  const PdfDummy({super.key, required this.warrantyRequestModel});
  static const String routePath = '/PdfDummy';
  final WarrantyRequestModel warrantyRequestModel;

  @override
  State<PdfDummy> createState() => _PdfDummyState();
}

class _PdfDummyState extends State<PdfDummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getBody(context, widget.warrantyRequestModel),
    );
  }

  Color pdfBorderColor = const Color(0xffFF912C);
  Divider divider() => Divider(
        color: pdfBorderColor,
        height: 2,
      );
  VerticalDivider verticalDivider() => VerticalDivider(
        color: pdfBorderColor,
        width: 2,
      );
  RichText rowItem(String key, String value) => RichText(
        text: TextSpan(
          text: key,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
  getBody(BuildContext context, WarrantyRequestModel warrantyRequestModel) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: pdfBorderColor),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'INSTALLATION CERTIFICATE',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
          ),
          divider(),
          Container(
            color: pdfBorderColor.withOpacity(0.2),
            child: SizedBox(
              height: 20,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Solar Water Heating System',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  verticalDivider(),
                  Expanded(
                    child: Text(
                      'No:. ${warrantyRequestModel.warrantyDetails?.warrantySerialNo}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  verticalDivider(),
                  const Expanded(
                    child: Text(
                      'Date:',
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
                const Text(
                  'Full Name of Client : ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  warrantyRequestModel.customers?.customerName ?? '',
                  style: const TextStyle(
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
                        color: pdfBorderColor.withOpacity(0.2),
                        child: const Text(
                          'Installation Address',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      divider(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          prepareAddress(
                              warrantyRequestModel.installationAddress),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
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
                        color: pdfBorderColor.withOpacity(0.2),
                        child: const Text(
                          'Owner\'s Address',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      divider(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          prepareAddress(warrantyRequestModel.ownerAddress),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
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
                          color: pdfBorderColor.withOpacity(0.2),
                          child:
                              Text('Tel. No: ${warrantyRequestModel.mobile2}'),
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
            color: pdfBorderColor.withOpacity(0.2),
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
            color: pdfBorderColor.withOpacity(0.2),
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
                    warrantyRequestModel.warrantyDetails?.warrantySerialNo ??
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
            color: pdfBorderColor.withOpacity(0.2),
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
            color: pdfBorderColor.withOpacity(0.2),
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
            color: pdfBorderColor.withOpacity(0.2),
            height: 100,
            child: Row(
              children: [
                Text('    '),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Customer Name & Sign :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalGap(5),
                    ],
                  ),
                ),
                verticalDivider(),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Customer Name & Sign :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
