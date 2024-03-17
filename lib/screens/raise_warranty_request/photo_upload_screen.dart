import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
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
import '../../utils/location_controller.dart';
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
  bool uploadingImage = false;
  // File? systemImage, serialNumberImage, aadhaarImage;
  File? systemImage, serialNumberImage;

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
            (uploadingImage || _api.status == ApiStatus.loading)
                ? Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    // width: 20,
                    // height: 20,
                    child: const CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () async {
                      if (await Permission
                          .location.status.isPermanentlyDenied) {
                        // ignore: use_build_context_synchronously
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          title: 'Location access needed',
                          desc:
                              'You have denied location request multiple times, you have to grant access from app settings',
                          onDismissCallback: (type) {},
                          autoDismiss: false,
                          btnOkOnPress: () async {
                            await openAppSettings();
                            navigatorKey.currentState?.pop();
                          },
                          btnOkText: 'Open settings',
                          btnOkColor: primaryColor,
                        ).show();

                        return;
                      }

                      Position? position = await determinePosition();
                      if (systemImage == null || serialNumberImage == null
                          // ||aadhaarImage == null
                          ) {
                        SnackBarService.instance
                            .showSnackBarError('Please select all images');
                        return;
                      }
                     
                        setState(() {
                          uploadingImage = true;
                        });
                        SnackBarService.instance.showSnackBarInfo(
                            'Uploading images, please wait it will take some time...');
                        widget.warrantyRequestModel.images =
                            await StorageService.uploadReqDocuments(
                                systemImage!,
                                serialNumberImage!,
                                // aadhaarImage!,
                                widget.warrantyRequestModel.customers
                                        ?.customerId
                                        .toString() ??
                                    '');
                        setState(() {
                          uploadingImage = false;
                        });
                        // widget.warrantyRequestModel.status =
                        //     AllocationStatus.PENDING.name;
                        // widget.warrantyRequestModel.initUserType = 'CUSTOMER';
                        // widget.warrantyRequestModel.initiatedBy = widget
                        //     .warrantyRequestModel.customers?.customerId
                        //     .toString();

                        String? lat = position.latitude.toString();
                        lat = lat.substring(0, min(lat.length, 10));
                        String? lon = position.longitude.toString();
                        lon = lon.substring(0, min(lon.length, 10));

                        if (lat.isEmpty || lon.isEmpty) {
                          SnackBarService.instance
                              .showSnackBarError('Please give location access');

                          if (await Permission.locationWhenInUse
                              .request()
                              .isGranted) {
                            // Either the permission was already granted before or the user just granted it.
                          }

                          return;
                        }

                        widget.warrantyRequestModel.lat = lat;

                        widget.warrantyRequestModel.lon = lon;
                        Map<String, dynamic> warrantyReq = {
                          "images": {
                            "imgLiveSystem": widget.warrantyRequestModel.images
                                    ?.imgLiveSystem ??
                                '',
                            "imgSystemSerialNo": widget.warrantyRequestModel
                                    .images?.imgSystemSerialNo ??
                                '',
                            "imgAadhar": ""
                          },
                          "lat": lat,
                          "lon": lon,
                        };

                        _api
                            .updateWarrantyRequest(warrantyReq,
                                widget.warrantyRequestModel.requestId!)
                            .then((value) {
                          if (value) {
                            SnackBarService.instance
                                .showSnackBarSuccess('Image uploaded');
                            Navigator.pop(context);
                          }
                        });
                     
                    },
                    child: const Text('Update'),
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
        // verticalGap(defaultPadding),
        // Text(
        //   'Aadhaar Card',
        //   style: Theme.of(context).textTheme.labelLarge,
        // ),
        // verticalGap(defaultPadding / 2),
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: hintColor.withOpacity(0.5),
        //     ),
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        //   alignment: Alignment.center,
        //   height: 200,
        //   width: double.infinity,
        //   child: aadhaarImage != null
        //       ? Image.file(
        //           aadhaarImage!,
        //           height: 200,
        //           width: double.infinity,
        //           fit: BoxFit.fitWidth,
        //         )
        //       : InkWell(
        //           onTap: () async {
        //             final ImagePicker picker = ImagePicker();
        //             final XFile? image =
        //                 await picker.pickImage(source: ImageSource.camera);
        //             if (image != null) {
        //               setState(() {
        //                 aadhaarImage = File(image.path);
        //               });
        //             }
        //           },
        //           child: const Icon(
        //             LineAwesomeIcons.camera,
        //             size: 60,
        //             color: Colors.grey,
        //           ),
        //         ),
        // ),
        verticalGap(defaultPadding * 1.5),
        // TextButton(
        //   onPressed: () {
        //     showPrivacyDialogbox(context);
        //   },
        //   child: Text('Read Terms and Conditions'),
        // ),
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
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: const Text("Terms and Conditions"),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               child: ListView(
  //                 shrinkWrap: true,
  //                 children: [
  //                   Text(Constants.termsAndConditions),
  //                   verticalGap(defaultPadding),
  //                   Row(
  //                     children: [
  //                       Checkbox(
  //                         value: agreement,
  //                         onChanged: (value) {
  //                           setState(() {
  //                             agreement = value ?? false;
  //                           });
  //                         },
  //                       ),
  //                       Expanded(
  //                         child: Text(
  //                           'I/we read and agreed and accepted the above terms and conditions',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .labelSmall
  //                               ?.copyWith(fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               okButton,
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  }
}
