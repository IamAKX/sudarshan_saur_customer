import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/warranty_request_model.dart';

import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';

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
            'Installation Address',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return ListView();
  }
}
