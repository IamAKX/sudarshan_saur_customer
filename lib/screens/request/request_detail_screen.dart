import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saur_customer/models/list_models/warranty_request_list.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
import 'package:saur_customer/utils/helper_method.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class RequestDetalScreen extends StatefulWidget {
  const RequestDetalScreen({super.key, required this.warrantyRequest});
  static const String routePath = '/requestDetalScreen';
  final WarrantyRequestModel warrantyRequest;

  @override
  State<RequestDetalScreen> createState() => _RequestDetalScreenState();
}

class _RequestDetalScreenState extends State<RequestDetalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView(
        children: [
          deviceDetailCard(context),
          customerDetailCard(context),
          dealerDetailCard(context),
          // stockistDetailCard(context),
          technicianDetailCard(context),
          plumberDetailCard(context),
          otherDetailCard(context),
          imageCard(context),
        ],
      ),
    );
  }

  Card deviceDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Serial Number',
              '${widget.warrantyRequest.warrantyDetails?.warrantySerialNo}',
            ),
            cardLargeDetail(context, 'Invoice Number',
                '${widget.warrantyRequest.invoiceNumber}'),
            cardLargeDetail(context, 'Installed On',
                '${widget.warrantyRequest.installationDate}'),
            cardLargeDetail(context, 'System Capacity',
                '${widget.warrantyRequest.warrantyDetails?.lpd}'),
            cardLargeDetail(context, 'Model No',
                '${widget.warrantyRequest.warrantyDetails?.model}'),
            cardLargeDetail(context, 'Guarantee',
                '${widget.warrantyRequest.warrantyDetails?.guaranteePeriod}'),
          ],
        ),
      ),
    );
  }

  Card imageCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Images',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            const Text('System'),
            verticalGap(defaultPadding / 2),
            CachedNetworkImage(
                imageUrl: widget.warrantyRequest.images?.imgLiveSystem ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 110,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const SizedBox(
                      height: 110,
                      child: Center(
                        child: Text('Unable to load image'),
                      ),
                    )),
            verticalGap(defaultPadding),
            const Text('Serial Number'),
            verticalGap(defaultPadding / 2),
            CachedNetworkImage(
                imageUrl:
                    widget.warrantyRequest.images?.imgSystemSerialNo ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 110,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const SizedBox(
                      height: 110,
                      child: Center(
                        child: Text('Unable to load image'),
                      ),
                    )),
            verticalGap(defaultPadding),
            const Text('Aadhaar'),
            verticalGap(defaultPadding / 2),
            CachedNetworkImage(
                imageUrl: widget.warrantyRequest.images?.imgAadhar ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 110,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const SizedBox(
                      height: 110,
                      child: Center(
                        child: Text('Unable to load image'),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Card otherDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Other Information',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.warrantyRequest.answers
                      ?.map(
                        (e) => RichText(
                          text: TextSpan(
                            text: e.questions?.questionText ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: textColorDark,
                                  height: 1.8,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\t${e.answerText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: textColorDark,
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }

  Card customerDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Name',
              '${widget.warrantyRequest.customers?.customerName}',
            ),
            cardLargeDetail(context, 'Installation Address',
                prepareAddress(widget.warrantyRequest.installationAddress)),
            cardLargeDetail(context, 'Owner\'s Address',
                prepareAddress(widget.warrantyRequest.ownerAddress)),
          ],
        ),
      ),
    );
  }

  Card stockistDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stockist Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Name',
              '${widget.warrantyRequest.warrantyDetails?.crmStockistName}',
            ),
            cardLargeDetail(
              context,
              'Phone',
              '${widget.warrantyRequest.warrantyDetails?.crmStockistMobileNo}',
            ),
            cardLargeDetail(
              context,
              'Email',
              '${widget.warrantyRequest.warrantyDetails?.crmStockistEmail}',
            ),
          ],
        ),
      ),
    );
  }

  Card technicianDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technician Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Name',
              '${widget.warrantyRequest.technicianInfo?.name}',
            ),
            cardLargeDetail(
              context,
              'Phone',
              '${widget.warrantyRequest.technicianInfo?.mobile}',
            ),
            cardLargeDetail(
              context,
              'Place',
              '${widget.warrantyRequest.technicianInfo?.place}',
            ),
          ],
        ),
      ),
    );
  }

  Card plumberDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plumber Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Name',
              '${widget.warrantyRequest.plumberInfo?.name}',
            ),
            cardLargeDetail(
              context,
              'Phone',
              '${widget.warrantyRequest.plumberInfo?.mobile}',
            ),
            cardLargeDetail(
              context,
              'Place',
              '${widget.warrantyRequest.plumberInfo?.place}',
            ),
          ],
        ),
      ),
    );
  }

  Card dealerDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dealer Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'Name',
              '${widget.warrantyRequest.dealerInfo?.name}',
            ),
            cardLargeDetail(
              context,
              'Phone',
              '${widget.warrantyRequest.dealerInfo?.mobile}',
            ),
            cardLargeDetail(
              context,
              'Place',
              '${widget.warrantyRequest.dealerInfo?.place}',
            ),
          ],
        ),
      ),
    );
  }

  Row cardLargeDetail(BuildContext context, String key, String value) {
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
        horizontalGap(10),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColorDark, fontWeight: FontWeight.w400, height: 1.5),
          ),
        )
      ],
    );
  }
}
