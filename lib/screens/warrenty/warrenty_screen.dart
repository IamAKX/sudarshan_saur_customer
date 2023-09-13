import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/warrenty/certificate_pdf.dart';
import 'package:saur_customer/screens/warrenty/pdf_dummy.dart';
import 'package:saur_customer/screens/warrenty/warranty_pdf.dart';
import 'package:saur_customer/services/snakbar_service.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/enum.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../models/list_models/warranty_request_list.dart';
import '../../services/api_service.dart';
import '../../utils/preference_key.dart';

class WarrentyScreen extends StatefulWidget {
  const WarrentyScreen({super.key, required this.switchTabs});
  final Function(int index) switchTabs;

  @override
  State<WarrentyScreen> createState() => _WarrentyScreenState();
}

class _WarrentyScreenState extends State<WarrentyScreen> {
  late ApiProvider _api;
  String selectedDealer = '';
  WarrantyRequestList? list;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getWarrantyRequestListByCustomerId(SharedpreferenceKey.getUserId())
        .then((value) {
      setState(() {
        list = value;

        list?.data?.retainWhere(
            (element) => element.status == AllocationStatus.APPROVED.name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warranty Card',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return list?.data?.isNotEmpty ?? false
        ? ListView.builder(
            itemCount: list?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) =>
                warrantyCard(context, list?.data?.elementAt(index)),
          )
        : noWarrantyCardWidget(context);
  }

  Card warrantyCard(BuildContext context, WarrantyRequestModel? model) {
    return Card(
      elevation: defaultPadding,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: warrantyCardSmallDetail(context, 'Serial No',
                      model?.warrantyDetails?.warrantySerialNo ?? ''),
                ),
                Expanded(
                  child: warrantyCardSmallDetail(context, 'Invoice',
                      model?.warrantyDetails?.invoiceNo ?? ''),
                ),
                Expanded(
                  child: warrantyCardSmallDetail(
                      context,
                      'Issued On',
                      DateTimeFormatter.onlyDateShort(
                          model?.warrantyDetails?.installationDate ?? '')),
                ),
              ],
            ),
            const Divider(
              color: dividerColor,
            ),
            warrantyCardLargeDetail(
              context,
              'Cust Name',
              model?.warrantyDetails?.crmCustomerName ?? '',
            ),
            verticalGap(5),
            warrantyCardLargeDetail(
              context,
              'State',
              model?.warrantyDetails?.state ?? '',
            ),
            verticalGap(5),
            warrantyCardLargeDetail(
              context,
              'Dealer',
              model?.dealerInfo?.name ?? '',
            ),
            verticalGap(5),
            warrantyCardLargeDetail(
              context,
              'System info',
              '${model?.warrantyDetails?.itemDescription} ${model?.warrantyDetails?.model ?? ''}',
            ),
            verticalGap(5),
            warrantyCardLargeDetail(
              context,
              'Valid Till',
              '${model?.warrantyDetails?.guaranteePeriod}',
            ),
            const Divider(
              color: dividerColor,
            ),
            verticalGap(5),
            Row(
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: 120,
                  color: primaryColor,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    makeCertificatePdf(model);
                    SnackBarService.instance.showSnackBarSuccess(
                        'Installation Certificate downloaded');
                  },
                  child: const Icon(
                    LineAwesomeIcons.certificate,
                    color: Colors.green,
                  ),
                ),
                horizontalGap(defaultPadding),
                InkWell(
                  onTap: () {
                    makePdf(model);
                    SnackBarService.instance
                        .showSnackBarSuccess('Guarantee Card downloaded');
                  },
                  child: const Icon(LineAwesomeIcons.address_card,
                      color: Colors.blue),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row warrantyCardLargeDetail(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColorLight,
                ),
          ),
        ),
        horizontalGap(5),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColorDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
        )
      ],
    );
  }

  RichText warrantyCardSmallDetail(
      BuildContext context, String key, String value) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '$value\n',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: textColorDark, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: key,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textColorLight,
                  ),
            )
          ]),
    );
  }

  Center noWarrantyCardWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/no_warranty.svg',
            width: 150,
          ),
          verticalGap(defaultPadding),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                'You have not generated any warranty yet.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: hintColor,
                    ),
              ),
            ),
          ),
          verticalGap(defaultPadding),
          ElevatedButton(
            onPressed: () {
              widget.switchTabs(1);
            },
            child: Text(
              'Get your warranty',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
