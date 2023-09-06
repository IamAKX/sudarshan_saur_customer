import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/photo_upload_screen.dart';
import 'package:saur_customer/utils/constants.dart';
import 'package:saur_customer/widgets/gaps.dart';

import '../../services/api_service.dart';
import '../../services/snakbar_service.dart';
import '../../utils/theme.dart';
import '../../widgets/build_dropdown_question copy.dart';
import '../../widgets/build_input_text_question.dart';

class OtherInformationScreen extends StatefulWidget {
  const OtherInformationScreen({
    super.key,
    required this.warrantyRequestModel,
  });
  final WarrantyRequestModel warrantyRequestModel;
  static const String routePath = '/otherInformationScreen';

  @override
  State<OtherInformationScreen> createState() => _OtherInformationScreenState();
}

class _OtherInformationScreenState extends State<OtherInformationScreen> {
  late ApiProvider _api;
  String answer1 = Constants.option1.first;
  String answer2 = Constants.option2.first;
  String answer3 = Constants.option3.first;
  final TextEditingController answer4 = TextEditingController();
  String answer5 = Constants.option4.first;
  final TextEditingController answer6 = TextEditingController();
  String answer7 = Constants.option5.first;
  String answer8 = Constants.option1.first;
  final TextEditingController answer9 = TextEditingController();
  String answer10 = Constants.option1.first;
  String answer11 = Constants.option7.first;
  String answer12 = Constants.option8.first;
  String answer13 = Constants.option8.first;

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
            'Other Information',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, PhotoUploadScreen.routePath,
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
      padding: const EdgeInsets.all(defaultPadding / 2),
      children: [
        BuildDropdownQuestion(
            question: 'System installed at south facing',
            options: Constants.option1,
            selectedAnswer: answer1),
        BuildDropdownQuestion(
            question: 'Hot water application',
            options: Constants.option2,
            selectedAnswer: answer2),
        BuildDropdownQuestion(
            question: 'Water source',
            options: Constants.option3,
            selectedAnswer: answer3),
        BuildInputTextQuestion(
            question: 'No of persons to hot water use', answer: answer4),
        BuildDropdownQuestion(
            question: 'Hot water using mode',
            options: Constants.option4,
            selectedAnswer: answer5),
        BuildInputTextQuestion(
            question: 'No of hot water using points (Bathrooms)',
            answer: answer6),
        BuildDropdownQuestion(
            question: 'Hot water using time',
            options: Constants.option5,
            selectedAnswer: answer7),
        BuildDropdownQuestion(
            question: 'Plumbing completed as per company guidelines',
            options: Constants.option1,
            selectedAnswer: answer8),
        BuildInputTextQuestion(
            question: 'Length of hot water pipeline', answer: answer9),
        BuildDropdownQuestion(
            question: 'System installed at shadow free area/place',
            options: Constants.option1,
            selectedAnswer: answer10),
        BuildDropdownQuestion(
            question: 'System amount paid fully or partly',
            options: Constants.option7,
            selectedAnswer: answer11),
        BuildDropdownQuestion(
            question: 'Dealer/Technician give all using tips and instructions',
            options: Constants.option8,
            selectedAnswer: answer12),
        BuildDropdownQuestion(
            question: 'Are you satisfied our representative response / work',
            options: Constants.option8,
            selectedAnswer: answer13),
      ],
    );
  }
}
