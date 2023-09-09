import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/conclusion_screen.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/constants.dart';
import 'package:saur_customer/utils/enum.dart';
import 'package:saur_customer/utils/preference_key.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../services/storage_service.dart';
import '../../utils/theme.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({
    super.key,
    required this.warrantyRequestModel,
  });
  final WarrantyRequestModel warrantyRequestModel;
  static const String routePath = '/photoUploadScreen';

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  late ApiProvider _api;
  File? systemImage, serialNumberImage, aadhaarImage;
  bool agreement = false;
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
            'Photo Upload',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (systemImage == null ||
                    serialNumberImage == null ||
                    aadhaarImage == null) {
                  SnackBarService.instance
                      .showSnackBarError('Please select all 3 images');
                  return;
                }
                if (agreement) {
                  SnackBarService.instance
                      .showSnackBarInfo('Uploading images...');
                  widget.warrantyRequestModel.images =
                      await StorageService.uploadReqDocuments(
                          systemImage!,
                          serialNumberImage!,
                          aadhaarImage!,
                          widget.warrantyRequestModel.customers?.customerId
                                  .toString() ??
                              '');
                  widget.warrantyRequestModel.status =
                      AllocationStatus.PENDING.name;
                  widget.warrantyRequestModel.initUserType = 'CUSTOMER';
                  widget.warrantyRequestModel.initiatedBy = widget
                      .warrantyRequestModel.customers?.customerId
                      .toString();
                  _api
                      .createNewWarrantyRequest(widget.warrantyRequestModel)
                      .then((value) {
                    if (value) {
                      prefs.remove(SharedpreferenceKey.serialNumber);
                      Navigator.pushNamed(context, ConclusionScreen.routePath,
                          arguments: widget.warrantyRequestModel);
                    }
                  });
                } else {
                  SnackBarService.instance.showSnackBarError(
                      'Please read and agree tems and conditions');
                  return;
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
        Text(
          'System Photo',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        verticalGap(defaultPadding / 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: hintColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          child: systemImage != null
              ? Image.file(
                  systemImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                )
              : InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        systemImage = File(image.path);
                      });
                    }
                  },
                  child: const Icon(
                    LineAwesomeIcons.camera,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
        ),
        verticalGap(defaultPadding),
        Text(
          'System Serial Number',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        verticalGap(defaultPadding / 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: hintColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          child: serialNumberImage != null
              ? Image.file(
                  serialNumberImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                )
              : InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        serialNumberImage = File(image.path);
                      });
                    }
                  },
                  child: const Icon(
                    LineAwesomeIcons.camera,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
        ),
        verticalGap(defaultPadding),
        Text(
          'Aadhaar Card',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        verticalGap(defaultPadding / 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: hintColor.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          child: aadhaarImage != null
              ? Image.file(
                  aadhaarImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                )
              : InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        aadhaarImage = File(image.path);
                      });
                    }
                  },
                  child: const Icon(
                    LineAwesomeIcons.camera,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
        ),
        verticalGap(defaultPadding * 1.5),
        TextButton(
          onPressed: () {
            showPrivacyDialogbox(context);
          },
          child: Text('Read Terms and Conditions'),
        ),
      ],
    );
  }

  showPrivacyDialogbox(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Terms and Conditions"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(Constants.termsAndConditions),
                    verticalGap(defaultPadding),
                    Row(
                      children: [
                        Checkbox(
                          value: agreement,
                          onChanged: (value) {
                            setState(() {
                              agreement = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'I/we read and agreed and accepted the above terms and conditions',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                okButton,
              ],
            );
          },
        );
      },
    );
  }
}
