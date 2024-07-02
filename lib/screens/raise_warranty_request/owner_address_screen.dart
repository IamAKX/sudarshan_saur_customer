import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/system_details_screen.dart';

import '../../main.dart';
import '../../models/address_model.dart';
import '../../models/list_models/state_district_list_model.dart';
import '../../models/state_district_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/constants.dart';
import '../../utils/helper_method.dart';
import '../../utils/preference_key.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';

class OwnerAddressScreen extends StatefulWidget {
  const OwnerAddressScreen({
    super.key,
    required this.warrantyRequestModel,
  });
  final WarrantyRequestModel warrantyRequestModel;
  static const String routePath = '/ownerAddressScreen';

  @override
  State<OwnerAddressScreen> createState() => _OwnerAddressScreenState();
}

class _OwnerAddressScreenState extends State<OwnerAddressScreen> {
  late ApiProvider _api;

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

  StateDistrictListModel? stateDistrictList;
  String? selectedState;
  String? selectedDistrict;

  @override
  void initState() {
    super.initState();
    stateDistrictList =
        StateDistrictListModel.fromMap(Constants.stateDistrictRaw);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    log(widget.warrantyRequestModel.ownerAddress?.toJson() ?? '');
    _houseNumberCtrl.text =
        widget.warrantyRequestModel.ownerAddress?.houseNo ?? '';
    _colonyCtrl.text = widget.warrantyRequestModel.ownerAddress?.area ?? '';
    _street1Ctrl.text = widget.warrantyRequestModel.ownerAddress?.street1 ?? '';
    _street2Ctrl.text = widget.warrantyRequestModel.ownerAddress?.street2 ?? '';
    _landmarkCtrl.text =
        widget.warrantyRequestModel.ownerAddress?.landmark ?? '';
    selectedState = widget.warrantyRequestModel.ownerAddress?.state;
    selectedDistrict = widget.warrantyRequestModel.ownerAddress?.district;
    _talukaCtrl.text = widget.warrantyRequestModel.ownerAddress?.taluk ?? '';
    _placeCtrl.text = widget.warrantyRequestModel.ownerAddress?.town ?? '';
    _zipCodeCtrl.text = widget.warrantyRequestModel.ownerAddress?.zipCode ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Owner Address',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!isValidInputs()) {
                  return;
                }
                AddressModel ownerAddress = AddressModel(
                    houseNo: _houseNumberCtrl.text ?? '',
                    area: _colonyCtrl.text ?? '',
                    street1: _street1Ctrl.text ?? '',
                    street2: _street2Ctrl.text ?? '',
                    landmark: _landmarkCtrl.text ?? '',
                    state: selectedState ?? '',
                    district: selectedDistrict ?? '',
                    country: 'India',
                    taluk: _talukaCtrl.text ?? '',
                    town: _placeCtrl.text ?? '',
                    zipCode: _zipCodeCtrl.text ?? '');

                widget.warrantyRequestModel.ownerAddress = ownerAddress;
                prefs.setString(SharedpreferenceKey.ongoingRequest,
                    widget.warrantyRequestModel.toJson());
                Navigator.pushNamed(context, SystemDetailScreen.routePath,
                    arguments: widget.warrantyRequestModel);
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
          'Solar water heater owner\'s address',
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
      ],
    );
  }

  bool isValidInputs() {
    // if (_houseNumberCtrl.text.isEmpty) {
    //   SnackBarService.instance
    //       .showSnackBarError('House Number cannot be empty');
    //   return false;
    // }
    // if (_colonyCtrl.text.isEmpty) {
    //   SnackBarService.instance
    //       .showSnackBarError('Colony / Area cannot be empty');
    //   return false;
    // }
    // if (_street1Ctrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Street 1 cannot be empty');
    //   return false;
    // }
    // if (_landmarkCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Landmark cannot be empty');
    //   return false;
    // }
    // if (selectedState?.trim().isEmpty ?? true) {
    //   SnackBarService.instance.showSnackBarError('State cannot be empty');
    //   return false;
    // }
    // if (selectedDistrict?.trim().isEmpty ?? true) {
    //   SnackBarService.instance.showSnackBarError('District cannot be empty');
    //   return false;
    // }
    // if (_talukaCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Taluka cannot be empty');
    //   return false;
    // }
    // if (_placeCtrl.text.isEmpty) {
    //   SnackBarService.instance
    //       .showSnackBarError('Place / Town cannot be empty');
    //   return false;
    // }
    // if (!isValidZipcode(_zipCodeCtrl.text)) {
    //   SnackBarService.instance.showSnackBarError('Invalid pincode');
    //   return false;
    // }
    return true;
  }
}
