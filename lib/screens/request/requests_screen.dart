import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/list_models/warranty_request_list.dart';
import 'package:saur_customer/screens/raise_warranty_request/installation_address_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/photo_upload_screen.dart';
import 'package:saur_customer/screens/request/new_request.dart';
import 'package:saur_customer/screens/request/request_detail_screen.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/preference_key.dart';
import 'package:saur_customer/widgets/input_field_light.dart';
import '../../main.dart';
import '../../models/warranty_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_dark.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.switchTabs});
  final Function(int index) switchTabs;

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
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
      });
    });
    await Permission.location.request().then((value) {
      log('location permission : $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guarantee Request',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSerialNumber(context);
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: primaryColor,
          size: 35,
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return list?.data?.isNotEmpty ?? false
        ? Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              itemCount: list?.data?.length ?? 0,
              itemBuilder: (context, index) =>
                  // Pending tile
                  ExpansionTile(
                textColor: textColorDark,
                collapsedBackgroundColor: Colors.white,
                backgroundColor: list?.data?.elementAt(index).images == null
                    ? rejectedColor.withOpacity(0.1)
                    : pendingColor.withOpacity(0.1),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Serial No ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: textColorLight,
                          ),
                    ),
                    Text(
                      '${list?.data?.elementAt(index).warrantyDetails?.warrantySerialNo}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: textColorDark,
                          ),
                    ),
                  ],
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateTimeFormatter.timesAgo(
                          list?.data?.elementAt(index).createdOn ?? ''),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: hintColor,
                          ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      width: 3,
                      height: defaultPadding * 0.75,
                      color: dividerColor,
                    ),
                    list?.data?.elementAt(index).images == null
                        ? Expanded(
                            child: Text(
                              'Urgent action pending',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          )
                        : Text(
                            getShortMessageByStatus(
                                list?.data?.elementAt(index).status ?? ''),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: getColorByStatus(
                                      list?.data?.elementAt(index).status ??
                                          ''),
                                ),
                          ),
                  ],
                ),
                children: [
                  Container(
                    width: double.maxFinite,
                    color: list?.data?.elementAt(index).images == null
                        ? Colors.red
                        : getColorByStatus(
                            list?.data?.elementAt(index).status ?? ''),
                    child: Container(
                      margin: const EdgeInsets.only(left: defaultPadding / 2),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding / 2),
                        child: list?.data?.elementAt(index).images == null
                            ? Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                        'Upload device image to process the guarantee request.'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                              PhotoUploadScreen.routePath,
                                              arguments:
                                                  list?.data?.elementAt(index))
                                          .then((value) => reloadScreen());
                                    },
                                    icon: const Icon(LineAwesomeIcons.camera),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      getDetailedMessageByStatus(
                                          list?.data?.elementAt(index).status ??
                                              ''),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RequestDetalScreen.routePath,
                                          arguments:
                                              list?.data?.elementAt(index));
                                    },
                                    icon: const Icon(
                                        LineAwesomeIcons.info_circle),
                                  )
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : noRequestWidget(context);
    //The serial number in your request is incorrect
  }

  Center noRequestWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/request_warranty.svg',
            width: 150,
          ),
          verticalGap(defaultPadding),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                'Not requested for guarantee card yet?\nHit the "+" button to raise new request.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: hintColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSerialNumber(BuildContext mainContext) {
    TextEditingController _serialNumberCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Serial Number'),
          content: InputFieldLight(
            hint: 'System Serial Number',
            controller: _serialNumberCtrl,
            keyboardType: TextInputType.number,
            obscure: false,
            icon: LineAwesomeIcons.plug,
            maxChar: 6,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(mainContext);
                SnackBarService.instance.showSnackBarInfo(
                    'Validating serial number. Please wait...');
                WarrantyModel? warrantyModel =
                    await _api.getDeviceBySerialNo(_serialNumberCtrl.text);
                if (warrantyModel == null) {
                } else {
                  log('Serial no validated : ${warrantyModel.toString()}');

                  await prefs.setString(
                      SharedpreferenceKey.serialNumber, _serialNumberCtrl.text);

                  Navigator.pushNamed(
                          mainContext, InstallationAddressScreen.routePath)
                      .then((value) => reloadScreen());
                }
              },
              child: Text('Okay'),
            )
          ],
        );
      },
    );
  }
}
