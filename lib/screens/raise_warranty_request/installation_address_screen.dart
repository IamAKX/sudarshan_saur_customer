import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/address_model.dart';
import 'package:saur_customer/models/list_models/state_district_list_model.dart';
import 'package:saur_customer/models/user_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/owner_address_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/system_details_screen.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/preference_key.dart';

import '../../models/state_district_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/constants.dart';
import '../../utils/enum.dart';
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
  UserModel? user;

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
  String? selectedState;
  String? selectedDistrict;

  @override
  void initState() {
    super.initState();
    stateDistrictList =
        StateDistrictListModel.fromMap(Constants.stateDistrictRaw);
    // selectedDistrict = stateDistrictList!.states!
    //     .firstWhere((element) => element.state == selectedState)
    //     .districts!
    //     .first;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    if (prefs.containsKey(SharedpreferenceKey.ongoingRequest)) {
      warrantyRequestModel = WarrantyRequestModel.fromJson(
          prefs.getString(SharedpreferenceKey.ongoingRequest)!);
      _whatsappNumberCtrl.text = warrantyRequestModel?.mobile2 ?? '';
      _houseNumberCtrl.text =
          warrantyRequestModel?.installationAddress?.houseNo ?? '';
      _colonyCtrl.text = warrantyRequestModel?.installationAddress?.area ?? '';
      _street1Ctrl.text =
          warrantyRequestModel?.installationAddress?.street1 ?? '';
      _street2Ctrl.text =
          warrantyRequestModel?.installationAddress?.street2 ?? '';
      _landmarkCtrl.text =
          warrantyRequestModel?.installationAddress?.landmark ?? '';
      selectedState = warrantyRequestModel?.installationAddress?.state ?? '';
      selectedDistrict =
          warrantyRequestModel?.installationAddress?.district ?? '';
      _talukaCtrl.text = warrantyRequestModel?.installationAddress?.taluk ?? '';
      _placeCtrl.text = warrantyRequestModel?.installationAddress?.town ?? '';
      _zipCodeCtrl.text =
          warrantyRequestModel?.installationAddress?.zipCode ?? '';
    } else {
      warrantyRequestModel = WarrantyRequestModel();
    }
    user = await _api
        .getUserByPhone(prefs.getString(SharedpreferenceKey.userPhone) ?? '');
    setState(() {
      warrantyRequestModel?.customers = user;
      _nameCtrl.text = user?.customerName ?? '';
      _phoneNumberCtrl.text = user?.mobileNo ?? '';
    });
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
                if (!isValidInputs()) {
                  return;
                }
                AddressModel installationAddress = AddressModel(
                    houseNo: _houseNumberCtrl.text,
                    area: _colonyCtrl.text,
                    street1: _street1Ctrl.text,
                    street2: _street2Ctrl.text,
                    landmark: _landmarkCtrl.text,
                    state: selectedState,
                    district: selectedDistrict,
                    country: 'India',
                    taluk: _talukaCtrl.text,
                    town: _placeCtrl.text,
                    zipCode: _zipCodeCtrl.text);
                warrantyRequestModel?.mobile2 = _whatsappNumberCtrl.text;
                warrantyRequestModel?.installationAddress = installationAddress;
                if (isOwnerAddressSame) {
                  warrantyRequestModel?.ownerAddress = installationAddress;
                  prefs.setString(SharedpreferenceKey.ongoingRequest,
                      warrantyRequestModel?.toJson() ?? '');
                  Navigator.pushNamed(context, SystemDetailScreen.routePath,
                      arguments: warrantyRequestModel);
                } else {
                  prefs.setString(SharedpreferenceKey.ongoingRequest,
                      warrantyRequestModel?.toJson() ?? '');
                  Navigator.pushNamed(context, OwnerAddressScreen.routePath,
                      arguments: warrantyRequestModel);
                }
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
            enabled: false,
            icon: LineAwesomeIcons.user),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Phone Number',
            controller: _phoneNumberCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            enabled: false,
            icon: LineAwesomeIcons.phone),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Whatsapp Number',
            controller: _whatsappNumberCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            maxChar: 10,
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
            child: DropdownButton2<String>(
              value: selectedState,
              underline: null,
              isExpanded: true,
              hint: Text(
                'Select ',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: stateDistrictList!.states!.map((StateDistrictModel value) {
                return DropdownMenuItem<String>(
                  value: value.state,
                  child: Text(value.state!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedDistrict = null;
                  log('selectedState : $selectedState');
                  // selectedDistrict = stateDistrictList!.states!
                  //     .firstWhere((element) => element.state == selectedState)
                  //     .districts!
                  //     .first;
                });
              },
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
            child: DropdownButton2<String>(
              value: selectedDistrict,
              underline: null,
              isExpanded: true,
              hint: Text(
                'Select ',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: selectedState == null
                  ? []
                  : stateDistrictList?.states
                          ?.firstWhere(
                              (element) => element.state == selectedState)
                          .districts
                          ?.map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList() ??
                      [],
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
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
            keyboardType: TextInputType.number,
            obscure: false,
            maxChar: 6,
            icon: LineAwesomeIcons.home),
        verticalGap(defaultPadding),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CheckboxListTile(
            tileColor: Colors.white,
            value: isOwnerAddressSame,
            onChanged: (value) {
              setState(() {
                isOwnerAddressSame = !isOwnerAddressSame;
              });
            },
            title:
                const Text('Is owner\'s address same as installation address '),
          ),
        )
      ],
    );
  }

  bool isValidInputs() {
    if (!isValidPhoneNumber(_whatsappNumberCtrl.text)) {
      SnackBarService.instance.showSnackBarError('Invalid whatsapp number');
      return false;
    }
    if (_houseNumberCtrl.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('House Number cannot be empty');
      return false;
    }
    if (_colonyCtrl.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Colony / Area cannot be empty');
      return false;
    }
    if (_street1Ctrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Street 1 cannot be empty');
      return false;
    }
    if (_landmarkCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Landmark cannot be empty');
      return false;
    }
    if (selectedState?.trim().isEmpty ?? true) {
      SnackBarService.instance.showSnackBarError('State cannot be empty');
      return false;
    }
    if (selectedDistrict?.trim().isEmpty ?? true) {
      SnackBarService.instance.showSnackBarError('District cannot be empty');
      return false;
    }
    if (_talukaCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Taluka cannot be empty');
      return false;
    }
    if (_placeCtrl.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Place / Town cannot be empty');
      return false;
    }
    if (!isValidZipcode(_zipCodeCtrl.text)) {
      SnackBarService.instance.showSnackBarError('Invalid pincode');
      return false;
    }
    return true;
  }
}
