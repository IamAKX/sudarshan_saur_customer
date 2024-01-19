import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/services/snakbar_service.dart';
import 'package:saur_customer/utils/preference_key.dart';
import 'package:saur_customer/utils/theme.dart';
import 'dart:convert';

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../utils/colors.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});
  static const String routePath = '/createTicketScreen';

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  late ApiProvider _api;
  UserModel? user;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _serialCtrl = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getCustomerById(prefs.getInt(SharedpreferenceKey.userId) ?? -1)
        .then((value) {
      setState(() {
        user = value;
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
          'Raise Ticket',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: _api.status == ApiStatus.loading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        TextField(
          keyboardType: TextInputType.name,
          autocorrect: true,
          controller: _nameCtrl,
          maxLines: 2,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'Title',
            labelText: 'Title',
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1,
                // style: BorderStyle.none,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
        verticalGap(defaultPadding),
        TextField(
          keyboardType: TextInputType.name,
          autocorrect: true,
          controller: _serialCtrl,
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'Serial Number',
            labelText: 'Serial Number',
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1,
                // style: BorderStyle.none,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
        verticalGap(defaultPadding),
        TextField(
          keyboardType: TextInputType.name,
          autocorrect: true,
          controller: _descCtrl,
          maxLines: 7,
          decoration: InputDecoration(
            hintText: 'Description',
            labelText: 'Description',
            alignLabelWithHint: true,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
        verticalGap(defaultPadding),
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
          child: image != null
              ? InkWell(
                  onTap: () {
                    setState(() {
                      image = null;
                    });
                  },
                  child: Image.file(
                    image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? imagex =
                        await picker.pickImage(source: ImageSource.camera);
                    if (imagex != null) {
                      setState(() {
                        image = File(imagex.path);
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
        ElevatedButton(
          onPressed: () async {
            if (_nameCtrl.text.isEmpty ||
                _descCtrl.text.isEmpty ||
                _serialCtrl.text.isEmpty ||
                image == null) {
              SnackBarService.instance
                  .showSnackBarInfo('All fields are mandatory');
              return;
            }
            List<int> imageBytes = image!.readAsBytesSync();
            Map<String, dynamic> reqBody = {};
            reqBody['name'] = _nameCtrl.text;
            reqBody['serial_no'] = _serialCtrl.text;
            reqBody['description'] = _descCtrl.text;
            reqBody['app_userid_c'] = user?.customerId;
            reqBody['state'] = 'Open';
            reqBody['type'] = 'Administration';
            reqBody['assigned_user_id'] = '1';
            reqBody['attach_photo_c'] = base64Encode(imageBytes);

            await _api.createTicket(reqBody).then((value) {
              if (value) {
                SnackBarService.instance.showSnackBarSuccess('Ticket created');
                Navigator.pop(context);
              } else {
                SnackBarService.instance
                    .showSnackBarError('Error in creating ticket');
              }
            });
          },
          child: const Text('Create Ticket'),
        )
      ],
    );
  }
}
