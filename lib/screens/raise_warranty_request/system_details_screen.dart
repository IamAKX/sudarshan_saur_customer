import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/main.dart';
import 'package:saur_customer/models/dealer_model.dart';
import 'package:saur_customer/models/plumber_model.dart';
import 'package:saur_customer/models/technician_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/other_information_screen.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';
import 'package:saur_customer/utils/preference_key.dart';

import '../../models/list_models/question_answer_model.dart';
import '../../models/list_models/question_model.dart';
import '../../models/warranty_model.dart';
import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/enum.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';
import 'conclusion_screen.dart';

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
  final TextEditingController _itemDesc = TextEditingController();
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
    _dealerInvoiceNoCtrl.text = widget.warrantyRequestModel.invoiceNumber ?? '';
    _dealerInvoiceDateCtrl.text = widget.warrantyRequestModel.invoiceDate ?? '';
    _installationDateCtrl.text =
        widget.warrantyRequestModel.installationDate ?? '';

    _dealerNameCtrl.text = widget.warrantyRequestModel.dealerInfo?.name ?? '';
    _dealerPhoneCtrl.text =
        widget.warrantyRequestModel.dealerInfo?.mobile ?? '';
    _dealerPlaceCtrl.text = widget.warrantyRequestModel.dealerInfo?.place ?? '';

    _technicianNameCtrl.text =
        widget.warrantyRequestModel.technicianInfo?.name ?? '';
    _technicianPhoneCtrl.text =
        widget.warrantyRequestModel.technicianInfo?.mobile ?? '';
    _technicianPlaceCtrl.text =
        widget.warrantyRequestModel.technicianInfo?.place ?? '';

    _plumberNameCtrl.text = widget.warrantyRequestModel.plumberInfo?.name ?? '';
    _plumberPhoneCtrl.text =
        widget.warrantyRequestModel.plumberInfo?.mobile ?? '';
    _plumberPlaceCtrl.text =
        widget.warrantyRequestModel.plumberInfo?.place ?? '';

    _serialNoCtrl.addListener(() async {
      if (_serialNoCtrl.text.isNotEmpty) {
        warrantyModel = await _api.getDeviceBySerialNo(_serialNoCtrl.text,
            showAlerts: false);
        if (warrantyModel != null) {
          _serialNoCtrl.text = warrantyModel?.warrantySerialNo ?? '';
          _lpdCtrl.text = warrantyModel?.lpd ?? '';
          _modelCtrl.text = warrantyModel?.model ?? '';
          _itemDesc.text = warrantyModel?.itemDescription ?? '';
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
            (_api.status == ApiStatus.loading)
                ? Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () {
                      if (!isValidInputs()) {
                        return;
                      }

                      widget.warrantyRequestModel.warrantyDetails =
                          warrantyModel;
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
                      widget.warrantyRequestModel.technicianInfo =
                          TechnicianModel(
                              mobile: _technicianPhoneCtrl.text,
                              name: _technicianNameCtrl.text,
                              place: _technicianPlaceCtrl.text);
                      widget.warrantyRequestModel.plumberInfo = PlumberModel(
                          mobile: _plumberPhoneCtrl.text,
                          name: _plumberNameCtrl.text,
                          place: _plumberPlaceCtrl.text);
                      prefs.setString(SharedpreferenceKey.ongoingRequest,
                          widget.warrantyRequestModel.toJson());
                      // Navigator.pushNamed(context, OtherInformationScreen.routePath,
                      //     arguments: widget.warrantyRequestModel);
                      widget.warrantyRequestModel.answers = [];
                      widget.warrantyRequestModel.status =
                          AllocationStatus.PENDING.name;
                      widget.warrantyRequestModel.initUserType = 'CUSTOMER';
                      widget.warrantyRequestModel.initiatedBy = widget
                          .warrantyRequestModel.customers?.customerId
                          .toString();
                      widget.warrantyRequestModel.answers = buildQnAList();
                      _api
                          .createNewWarrantyRequest(widget.warrantyRequestModel)
                          .then((value) {
                        if (value) {
                          // prefs.remove(SharedpreferenceKey.serialNumber);
                          // prefs.remove(SharedpreferenceKey.ongoingRequest);
                          prefs.clear();
                          Navigator.pushNamedAndRemoveUntil(context,
                              ConclusionScreen.routePath, (route) => false);
                        }
                      });
                    },
                    child: const Text('Submit'),
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
          'System Details',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Serial Number',
            controller: _serialNoCtrl,
            keyboardType: TextInputType.number,
            obscure: false,
            enabled: false,
            maxChar: 6,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'LPD',
        //     controller: _lpdCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     enabled: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Model Number',
            controller: _modelCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            enabled: false,
            icon: LineAwesomeIcons.plug),
        verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Item Description',
            controller: _itemDesc,
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
        InkWell(
          onTap: () => selectDealerInvoiceDate(context),
          child: InputFieldLight(
              hint: 'Dealer Invoice Date',
              controller: _dealerInvoiceDateCtrl,
              keyboardType: TextInputType.datetime,
              obscure: false,
              enabled: false,
              icon: LineAwesomeIcons.plug),
        ),
        verticalGap(defaultPadding / 2),
        InkWell(
          onTap: () => selectDealerInstallationDate(context),
          child: InputFieldLight(
              hint: 'Installation Date',
              controller: _installationDateCtrl,
              keyboardType: TextInputType.datetime,
              enabled: false,
              obscure: false,
              icon: LineAwesomeIcons.plug),
        ),
        verticalGap(defaultPadding),
        const Text(
          'Dealer Detail',
        ),
        verticalGap(defaultPadding),
        // InputFieldLight(
        //     hint: 'Dealer Name',
        //     controller: _dealerNameCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'Dealer Mobile Number',
        //     controller: _dealerPhoneCtrl,
        //     keyboardType: TextInputType.phone,
        //     maxChar: 10,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        InputFieldLight(
            hint: 'Dealer Place',
            controller: _dealerPlaceCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding),
        // const Text(
        //   'Technician Detail',
        // ),
        // verticalGap(defaultPadding),
        // InputFieldLight(
        //     hint: 'Technician Name',
        //     controller: _technicianNameCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'Technician Mobile Number',
        //     controller: _technicianPhoneCtrl,
        //     keyboardType: TextInputType.phone,
        //     maxChar: 10,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'Technician Place',
        //     controller: _technicianPlaceCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding),
        // const Text(
        //   'Plumber Detail',
        // ),
        // verticalGap(defaultPadding),
        // InputFieldLight(
        //     hint: 'Plumber Name',
        //     controller: _plumberNameCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'Plumber Mobile Number',
        //     controller: _plumberPhoneCtrl,
        //     maxChar: 10,
        //     keyboardType: TextInputType.phone,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
        // verticalGap(defaultPadding / 2),
        // InputFieldLight(
        //     hint: 'Plumber Place',
        //     controller: _plumberPlaceCtrl,
        //     keyboardType: TextInputType.name,
        //     obscure: false,
        //     icon: LineAwesomeIcons.plug),
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
    // if (_dealerInvoiceNoCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Enter dealer invoice number');
    //   return false;
    // }
    // if (_dealerInvoiceDateCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Select dealer invoice date');
    //   return false;
    // }
    if (_installationDateCtrl.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Select installation date');
      return false;
    }
    if (!DateTimeFormatter.isValidInstallationDate(
        _dealerInvoiceDateCtrl.text, _installationDateCtrl.text)) {
      SnackBarService.instance.showSnackBarError(
          'Installation date should be after dealer invoice date');
      return false;
    }
    // if (_dealerNameCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Enter dealer name');
    //   return false;
    // }
    // if (!isValidPhoneNumber(_dealerPhoneCtrl.text)) {
    //   SnackBarService.instance.showSnackBarError('Invalid dealer phone number');
    //   return false;
    // }
    // if (_dealerPlaceCtrl.text.isEmpty) {
    //   SnackBarService.instance.showSnackBarError('Enter dealer place');
    //   return false;
    // }

    // if (_dealerPhoneCtrl.text == _plumberPhoneCtrl.text ||
    //     _dealerPhoneCtrl.text == _technicianPhoneCtrl.text) {
    //   SnackBarService.instance.showSnackBarError(
    //       'Dealer mobile number cannot be same as technician or plumber mobile number');
    //   return false;
    // }

    // if (_technicianPhoneCtrl.text.isNotEmpty) {
    //   if (!isValidPhoneNumber(_technicianPhoneCtrl.text)) {
    //     SnackBarService.instance.showSnackBarError('Invalid technician number');
    //     return false;
    //   }
    // }

    // if (_plumberPhoneCtrl.text.isNotEmpty) {
    //   if (!isValidPhoneNumber(_plumberPhoneCtrl.text)) {
    //     SnackBarService.instance.showSnackBarError('Invalid plumber number');
    //     return false;
    //   }
    // }

    return true;
  }

  Future<void> selectDealerInvoiceDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // Initialize with the current date

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900), // Adjust as needed
      lastDate: DateTime(2123), // Adjust as needed
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      _dealerInvoiceDateCtrl.text =
          DateTimeFormatter.formatDatePicker(selectedDate);
    }
  }

  Future<void> selectDealerInstallationDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // Initialize with the current date

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900), // Adjust as needed
      lastDate: DateTime(2123), // Adjust as needed
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      _installationDateCtrl.text =
          DateTimeFormatter.formatDatePicker(selectedDate);
    }
  }

  List<QuestionAnswerModel> buildQnAList() {
    return [
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 1)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 2)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 3)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 4)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 5)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 6)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 7)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 8)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 9)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 10)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 11)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 12)),
      QuestionAnswerModel(
          answerText: '', questions: QuestionModel(questionId: 13)),
    ];
  }
}
