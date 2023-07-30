import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/list_models/dealer_last_model.dart';
import 'package:saur_customer/utils/preference_key.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/input_field_light.dart';
import 'package:saur_customer/widgets/primary_button_dark.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../models/dealer_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../widgets/alert_popup.dart';
import '../../widgets/gaps.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});
  static const String routePath = '/newRequestScreen';

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final TextEditingController _serialNoCtrl = TextEditingController();
  final TextEditingController _dealerNameCtrl = TextEditingController();
  DealerListModel? dealerList;
  late ApiProvider _api;
  String selectedDealer = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api.getAllDealers().then((value) {
      setState(() {
        dealerList = value;
        log('dealerList = ${dealerList?.data?.length}');
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
          'New Request',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        Text(
          'Enter device serial number',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: hintColor,
              ),
        ),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
          hint: 'Serial number',
          controller: _serialNoCtrl,
          keyboardType: TextInputType.text,
          obscure: false,
          icon: LineAwesomeIcons.sort_numeric_up,
        ),
        verticalGap(defaultPadding),
        Text(
          'Enter Dealer Name',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: hintColor,
              ),
        ),
        verticalGap(defaultPadding / 2),
        EasyAutocomplete(
          controller: _dealerNameCtrl,
          suggestions:
              dealerList?.data?.map((e) => e.businessName ?? '').toList() ?? [],
          onSubmitted: (value) {
            setState(() {
              selectedDealer = value;
            });
          },
          suggestionBackgroundColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Dealer name',
            filled: true,
            prefixIcon: Icon(LineAwesomeIcons.store),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Visibility(
            visible: selectedDealer.isNotEmpty,
            child: Chip(
              label: Text(
                selectedDealer,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              backgroundColor: primaryColor,
              deleteIcon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onDeleted: () {
                setState(() {
                  selectedDealer = '';
                  _dealerNameCtrl.text = '';
                });
              },
            ),
          ),
        ),
        verticalGap(defaultPadding * 2),
        PrimaryButtonDark(
          onPressed: () async {
            if (_serialNoCtrl.text.isEmpty) {
              SnackBarService.instance.showSnackBarError('Enter serial number');
              return;
            }
            DealerModel? dealer = dealerList?.data?.firstWhereOrNull(
                (element) =>
                    element.businessName?.trim().toLowerCase() ==
                    selectedDealer.trim().toLowerCase());
            if (dealer == null) {
              SnackBarService.instance.showSnackBarError('Invalid dealer');
              return;
            }
            int? customerId = prefs.getInt(SharedpreferenceKey.userId);
            Map<String, dynamic> reqBody = {
              "warrantySerialNo": _serialNoCtrl.text,
              "dealers": {"dealerId": dealer.dealerId},
              "customer": {"customerId": customerId},
              "allocationStatus": "PENDING",
              "initUserType": "CUSTOMER",
              "initiatedBy": "$customerId",
              "approvedBy": ""
            };

            _api.createNewWarrantyRequest(reqBody).then((value) {
              if (value) {
                _serialNoCtrl.text = '';
                _dealerNameCtrl.text = '';
                showPopup(context, DialogType.success, 'Done!',
                    'We have received your request. You will hear from us in 24 hours');
              }
            });
          },
          label: 'Create',
          isDisabled: _api.status == ApiStatus.loading,
          isLoading: _api.status == ApiStatus.loading,
        ),
      ],
    );
  }
}
