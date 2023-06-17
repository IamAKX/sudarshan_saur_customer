import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:saur_customer/utils/colors.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:saur_customer/widgets/gaps.dart';

class WarrentyScreen extends StatefulWidget {
  const WarrentyScreen({super.key, required this.switchTabs});
  final Function(int index) switchTabs;

  @override
  State<WarrentyScreen> createState() => _WarrentyScreenState();
}

class _WarrentyScreenState extends State<WarrentyScreen> {
  bool isListVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => setState(() {
            isListVisible = !isListVisible;
          }),
          child: Text(
            'Warranty Card',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return isListVisible
        ? ListView(
            children: [
              Card(
                elevation: defaultPadding,
                margin: const EdgeInsets.all(defaultPadding),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: warrantyCardSmallDetail(
                                context, 'Serial No', '268899'),
                          ),
                          Expanded(
                            child: warrantyCardSmallDetail(
                                context, 'Invoice', 'C00374/525'),
                          ),
                          Expanded(
                            child: warrantyCardSmallDetail(
                                context, 'Issued On', '2022-11-15'),
                          ),
                        ],
                      ),
                      const Divider(
                        color: dividerColor,
                      ),
                      warrantyCardLargeDetail(
                        context,
                        'Cust Name',
                        'Shree Sunil Desai',
                      ),
                      verticalGap(5),
                      warrantyCardLargeDetail(
                        context,
                        'Cust Address',
                        'No:7 United Building, Paradise, M G Road, Hyderabad, Andhra Pradesh - 500003',
                      ),
                      verticalGap(5),
                      warrantyCardLargeDetail(
                        context,
                        'Dealer',
                        'Rajat Soni',
                      ),
                      verticalGap(5),
                      warrantyCardLargeDetail(
                        context,
                        'System info',
                        '200 WUGL-A 58X2100-10 Guarantee*',
                      ),
                      verticalGap(5),
                      warrantyCardLargeDetail(
                        context,
                        'Valid Till',
                        '2037-11-15',
                      ),
                      const Divider(
                        color: dividerColor,
                      ),
                      verticalGap(5),
                      Row(
                        children: [
                          Image.asset(
                            'assets/logo/logo.png',
                            width: 120,
                            color: primaryColor,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              LineAwesomeIcons.what_s_app,
                              color: Colors.green,
                            ),
                          ),
                          horizontalGap(defaultPadding),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              LineAwesomeIcons.envelope_1,
                              color: Colors.red,
                            ),
                          ),
                          horizontalGap(defaultPadding),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                                LineAwesomeIcons.alternate_cloud_download,
                                color: Colors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        : noWarrantyCardWidget(context);
  }

  Row warrantyCardLargeDetail(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColorLight,
                ),
          ),
        ),
        horizontalGap(5),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColorDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
        )
      ],
    );
  }

  RichText warrantyCardSmallDetail(
      BuildContext context, String key, String value) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '$value\n',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: textColorDark, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: key,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textColorLight,
                  ),
            )
          ]),
    );
  }

  Center noWarrantyCardWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/no_warranty.svg',
            width: 150,
          ),
          verticalGap(defaultPadding),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                'You have not generated any warranty yet.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: hintColor,
                    ),
              ),
            ),
          ),
          verticalGap(defaultPadding),
          ElevatedButton(
            onPressed: () {
              widget.switchTabs(1);
            },
            child: Text(
              'Get your warranty',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
