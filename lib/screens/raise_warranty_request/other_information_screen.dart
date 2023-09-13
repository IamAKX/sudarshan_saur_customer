import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../../widgets/build_input_text_question.dart';
import '../../widgets/gaps.dart';

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
  int errorIndex = -1;
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
                debugPrint(buildQnAList().toString());
                if (!isValidInputs()) {
                  setState(() {});
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
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 1) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'System installed at south facing',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer1,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option1
                          .map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer1 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 2) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Hot water application',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer2,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option2
                          .map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer2 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 3) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Water source',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer3,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option3
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer3 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildInputTextQuestion(
            question: 'No of persons to hot water use',
            answer: answer4,
            showError: errorIndex == 4),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 5) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Hot water using mode',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer5,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option4
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer5 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildInputTextQuestion(
            question: 'No of hot water using points (Bathrooms)',
            answer: answer6,
            showError: errorIndex == 6),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 7) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Hot water using time',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer7,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option5
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer7 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 8) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Plumbing completed as per company guidelines',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer8,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option1
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer8 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildInputTextQuestion(
            question: 'Length of hot water pipeline',
            answer: answer9,
            showError: errorIndex == 9),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 10) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'System installed at shadow free area/place',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer10,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option1
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer10 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 11) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'System amount paid fully or partly',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer11,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option7
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer11 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 12) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Dealer/Technician give all using tips and instructions',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer12,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option8
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer12 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: (errorIndex == 13) ? Colors.red : Colors.white),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Are you satisfied our representative response / work',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                horizontalGap(defaultPadding),
                Expanded(
                  flex: 3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: answer13,
                      hint: Text(
                        'Select ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      underline: null,
                      isExpanded: true,
                      items: Constants.option8
                          ?.map((val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          answer13 = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  bool isValidInputs() {
    if (answer1?.isEmpty ?? true) {
      errorIndex = 1;

      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer2?.isEmpty ?? true) {
      errorIndex = 2;

      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer3?.isEmpty ?? true) {
      errorIndex = 3;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer4.text.trim().isEmpty) {
      errorIndex = 4;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer5?.isEmpty ?? true) {
      errorIndex = 5;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer6.text.trim().isEmpty) {
      errorIndex = 6;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer7?.isEmpty ?? true) {
      errorIndex = 7;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer8?.isEmpty ?? true) {
      errorIndex = 8;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer9.text.trim().isEmpty) {
      errorIndex = 9;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer10?.isEmpty ?? true) {
      errorIndex = 10;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer11?.isEmpty ?? true) {
      errorIndex = 11;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer12?.isEmpty ?? true) {
      errorIndex = 12;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    if (answer13?.isEmpty ?? true) {
      errorIndex = 13;
      SnackBarService.instance.showSnackBarError('All fields are mandator');
      return false;
    }
    errorIndex = -1;
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
