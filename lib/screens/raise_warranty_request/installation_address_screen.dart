import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/list_models/state_district_list_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/owner_address_screen.dart';

import '../../models/state_district_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';

class InstallationAddressScreen extends StatefulWidget {
  const InstallationAddressScreen({super.key});
  static const String routePath = '/installationAddressScreen';

  @override
  State<InstallationAddressScreen> createState() =>
      _InstallationAddressScreenState();
}

class _InstallationAddressScreenState extends State<InstallationAddressScreen> {
  late ApiProvider _api;
  WarrantyRequestModel? warrantyRequestModel;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _whatsappNumberCtrl = TextEditingController();
  final TextEditingController _houseNumberCtrl = TextEditingController();
  final TextEditingController _colonyCtrl = TextEditingController();
  final TextEditingController _street1Ctrl = TextEditingController();
  final TextEditingController _street2Ctrl = TextEditingController();
  final TextEditingController _landmarkCtrl = TextEditingController();
  final TextEditingController _talukaCtrl = TextEditingController();
  final TextEditingController _placeCtrl = TextEditingController();
  final TextEditingController _zipCodeCtrl = TextEditingController();
  bool isOwnerAddressSame = false;

  StateDistrictListModel? stateDistrictList;
  String selectedState = 'Andhra Pradesh';
  String selectedDistrict = '';

  @override
  void initState() {
    super.initState();
    stateDistrictList =
        StateDistrictListModel.fromMap(Constants.stateDistrictRaw);
    selectedDistrict = stateDistrictList!.states!
        .firstWhere((element) => element.state == selectedState)
        .districts!
        .first;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    warrantyRequestModel = WarrantyRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Installation Address',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, OwnerAddressScreen.routePath,
                    arguments: warrantyRequestModel);
              },
              child: const Text('Next'),
            ),
          ],
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        const Text(
          'User Detail',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Name',
            controller: _nameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.user),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Phone Number',
            controller: _phoneNumberCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            icon: LineAwesomeIcons.phone),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Whatsapp Number',
            controller: _whatsappNumberCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            icon: LineAwesomeIcons.what_s_app),
        verticalGap(defaultPadding * 2),
        const Text(
          'Solar water heater installation address',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'House Number',
            controller: _houseNumberCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Colony / Area',
            controller: _colonyCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Street 1',
            controller: _street1Ctrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Street 2',
            controller: _street2Ctrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Landmark',
            controller: _landmarkCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        const Text('     Select State'),
        verticalGap(defaultPadding / 2),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(defaultPadding * 3),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedState,
              underline: null,
              isExpanded: true,
              items: stateDistrictList!.states!.map((StateDistrictModel value) {
                return DropdownMenuItem<String>(
                  value: value.state,
                  child: Text(value.state!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value!;
                  selectedDistrict = stateDistrictList!.states!
                      .firstWhere((element) => element.state == selectedState)
                      .districts!
                      .first;
                });
              },
              hint: Text('Select state'),
            ),
          ),
        ),
        verticalGap(defaultPadding),
        const Text('     Select District'),
        verticalGap(defaultPadding / 2),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(defaultPadding * 3),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDistrict,
              underline: null,
              isExpanded: true,
              items: stateDistrictList!.states!
                  .firstWhere((element) => element.state == selectedState)
                  .districts!
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value!;
                });
              },
            ),
          ),
        ),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Taluka',
            controller: _talukaCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Place / Town',
            controller: _placeCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Pincode',
            controller: _zipCodeCtrl,
            keyboardType: TextInputType.text,
            obscure: false,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        CheckboxListTile(
          tileColor: Colors.white,
          value: isOwnerAddressSame,
          onChanged: (value) {
            setState(() {
              isOwnerAddressSame = !isOwnerAddressSame;
            });
          },
          title:
              const Text('Is owner\'s address same as installation address '),
        )
      ],
    );
  }
}
