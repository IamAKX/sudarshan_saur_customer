import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/models/list_models/question_answer_model.dart';
import 'package:saur_customer/models/list_models/question_model.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/raise_warranty_request/photo_upload_screen.dart';
import 'package:saur_customer/utils/constants.dart';

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
  String? answer1; // = Constants.option1.first;
  String? answer2; // = Constants.option2.first;
  String? answer3; // = Constants.option3.first;
  final TextEditingController answer4 = TextEditingController();
  String? answer5; //= Constants.option4.first;
  final TextEditingController answer6 = TextEditingController();
  String? answer7; //= Constants.option5.first;
  String? answer8; // = Constants.option1.first;
  final TextEditingController answer9 = TextEditingController();
  String? answer10; // = Constants.option1.first;
  String? answer11; // = Constants.option7.first;
  String? answer12; // = Constants.option8.first;
  String? answer13; // = Constants.option8.first;

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
                if (!isValidInputs()) {
                  return;
                }

                widget.warrantyRequestModel.answers = buildQnAList();

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

  bool isValidInputs() {
    if ((answer1?.isEmpty ?? true) ||
        (answer2?.isEmpty ?? true) ||
        (answer3?.isEmpty ?? true) ||
        answer4.text.isEmpty ||
        (answer5?.isEmpty ?? true) ||
        answer6.text.isEmpty ||
        (answer7?.isEmpty ?? true) ||
        (answer8?.isEmpty ?? true) ||
        answer9.text.isEmpty ||
        (answer10?.isEmpty ?? true) ||
        (answer11?.isEmpty ?? true) ||
        (answer12?.isEmpty ?? true) ||
        (answer13?.isEmpty ?? true)) {
      SnackBarService.instance.showSnackBarError('All fields are mandatory');
      return false;
    }
    return true;
  }

  List<QuestionAnswerModel> buildQnAList() {
    return [
      QuestionAnswerModel(
          answerText: answer1, questions: QuestionModel(questionId: 1)),
      QuestionAnswerModel(
          answerText: answer2, questions: QuestionModel(questionId: 2)),
      QuestionAnswerModel(
          answerText: answer3, questions: QuestionModel(questionId: 3)),
      QuestionAnswerModel(
          answerText: answer4.text, questions: QuestionModel(questionId: 4)),
      QuestionAnswerModel(
          answerText: answer5, questions: QuestionModel(questionId: 5)),
      QuestionAnswerModel(
          answerText: answer6.text, questions: QuestionModel(questionId: 6)),
      QuestionAnswerModel(
          answerText: answer7, questions: QuestionModel(questionId: 7)),
      QuestionAnswerModel(
          answerText: answer8, questions: QuestionModel(questionId: 8)),
      QuestionAnswerModel(
          answerText: answer9.text, questions: QuestionModel(questionId: 9)),
      QuestionAnswerModel(
          answerText: answer10, questions: QuestionModel(questionId: 10)),
      QuestionAnswerModel(
          answerText: answer11, questions: QuestionModel(questionId: 11)),
      QuestionAnswerModel(
          answerText: answer12, questions: QuestionModel(questionId: 12)),
      QuestionAnswerModel(
          answerText: answer13, questions: QuestionModel(questionId: 13)),
    ];
  }
}
