import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/dealer_model.dart';
import 'package:saur_customer/models/plumber_model.dart';
import 'package:saur_customer/models/technician_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/other_information_screen.dart';
import 'package:saur_customer/utils/preference_key.dart';

import '../../models/warranty_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';

class SystemDetailScreen extends StatefulWidget {
  const SystemDetailScreen({
    super.key,
    required this.warrantyRequestModel,
  });
  final WarrantyRequestModel warrantyRequestModel;
  static const String routePath = '/systemDetailScreen';

  @override
  State<SystemDetailScreen> createState() => _SystemDetailScreenState();
}

class _SystemDetailScreenState extends State<SystemDetailScreen> {
  late ApiProvider _api;

  final TextEditingController _serialNoCtrl = TextEditingController();
  final TextEditingController _lpdCtrl = TextEditingController();
  final TextEditingController _modelCtrl = TextEditingController();
  final TextEditingController _dealerInvoiceNoCtrl = TextEditingController();
  final TextEditingController _dealerInvoiceDateCtrl = TextEditingController();
  final TextEditingController _installationDateCtrl = TextEditingController();
  final TextEditingController _dealerNameCtrl = TextEditingController();
  final TextEditingController _dealerPhoneCtrl = TextEditingController();
  final TextEditingController _dealerPlaceCtrl = TextEditingController();
  final TextEditingController _technicianNameCtrl = TextEditingController();
  final TextEditingController _technicianPhoneCtrl = TextEditingController();
  final TextEditingController _technicianPlaceCtrl = TextEditingController();
  final TextEditingController _plumberNameCtrl = TextEditingController();
  final TextEditingController _plumberPhoneCtrl = TextEditingController();
  final TextEditingController _plumberPlaceCtrl = TextEditingController();
  WarrantyModel? warrantyModel;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    _serialNoCtrl.addListener(() async {
      if (_serialNoCtrl.text.isNotEmpty) {
        warrantyModel = await _api.getDeviceBySerialNo(_serialNoCtrl.text,
            showAlerts: false);
        if (warrantyModel != null) {
          _lpdCtrl.text = warrantyModel?.lpd ?? '';
          _modelCtrl.text = warrantyModel?.model ?? '';
        } else {
          _lpdCtrl.text = '';
          _modelCtrl.text = '';
        }
      }
    });
    _serialNoCtrl.text =
        prefs.getString(SharedpreferenceKey.serialNumber) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'System Detail',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!isValidInputs()) {
                  return;
                }

                widget.warrantyRequestModel.warrantyDetails = warrantyModel;
                widget.warrantyRequestModel.invoiceNumber =
                    _dealerInvoiceNoCtrl.text;
                widget.warrantyRequestModel.invoiceDate =
                    _dealerInvoiceDateCtrl.text;
                widget.warrantyRequestModel.installationDate =
                    _installationDateCtrl.text;
                widget.warrantyRequestModel.dealerInfo = DealerModel(
                    mobile: _dealerPhoneCtrl.text,
                    name: _dealerNameCtrl.text,
                    place: _dealerPlaceCtrl.text);
                widget.warrantyRequestModel.technicianInfo = TechnicianModel(
                    mobile: _technicianPhoneCtrl.text,
                    name: _technicianNameCtrl.text,
                    place: _technicianPlaceCtrl.text);
                widget.warrantyRequestModel.plumberInfo = PlumberModel(
                    mobile: _plumberPhoneCtrl.text,
                    name: _plumberNameCtrl.text,
                    place: _plumberPlaceCtrl.text);

                Navigator.pushNamed(context, OtherInformationScreen.routePath,
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
          'Device Detail',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Serial Number',
            controller: _serialNoCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'LPD',
            controller: _lpdCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            enabled: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Model Number',
            controller: _modelCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            enabled: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Dealer Invoice Number',
            controller: _dealerInvoiceNoCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Dealer Invoice Date',
            controller: _dealerInvoiceDateCtrl,
            keyboardType: TextInputType.datetime,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Installation Date',
            controller: _installationDateCtrl,
            keyboardType: TextInputType.datetime,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding),
        const Text(
          'Dealer Detail',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Dealer Name',
            controller: _dealerNameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Dealer Phone',
            controller: _dealerPhoneCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Dealer Place',
            controller: _dealerPlaceCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding),
        const Text(
          'Technician Detail',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Technician Name',
            controller: _technicianNameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Technician Phone',
            controller: _technicianPhoneCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Technician Place',
            controller: _technicianPlaceCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding),
        const Text(
          'Plumber Detail',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Plumber Name',
            controller: _plumberNameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Plumber Phone',
            controller: _plumberPhoneCtrl,
            keyboardType: TextInputType.phone,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Plumber Place',
            controller: _plumberPlaceCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
      ],
    );
  }

  bool isValidInputs() {
    if (_serialNoCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter serial number');
      return false;
    }

    if (warrantyModel == null ||
        _lpdCtrl.text.isEmpty ||
        _modelCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Invalid serial number');
      return false;
    }
    if (_dealerInvoiceNoCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter dealer invoice number');
      return false;
    }
    if (_dealerInvoiceDateCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter dealer invoice date');
      return false;
    }
    if (_installationDateCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter installation date');
      return false;
    }
    if (_dealerNameCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter dealer name');
      return false;
    }
    if (_dealerPhoneCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter dealer phone number');
      return false;
    }
    if (_dealerPlaceCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter dealer place');
      return false;
    }

    if (_dealerPhoneCtrl.text == _plumberPhoneCtrl.text ||
        _dealerPhoneCtrl.text == _technicianPhoneCtrl.text) {
      SnackBarService.instance.showSnackBarError(
          'Enter dealer phone cannot be same as technician or plumber phone');
      return false;
    }

    return true;
  }
}
