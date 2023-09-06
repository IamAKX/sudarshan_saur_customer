import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/other_information_screen.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {}

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
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Model Number',
            controller: _modelCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
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
            keyboardType: TextInputType.name,
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
            keyboardType: TextInputType.name,
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
            keyboardType: TextInputType.name,
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
}
