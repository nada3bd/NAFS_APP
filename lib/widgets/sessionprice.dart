import 'package:flutter/material.dart';
import 'package:grad_app/widgets/labelbox.dart';

class SessionPriceInfo extends StatelessWidget {
  final String session;
  final String price;

  const SessionPriceInfo(
      {super.key, required this.session, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LabelBox(title: 'Session time', value: session , color: Colors.grey[700],),
        LabelBox(title: 'Price', value: price , color: Colors.grey[700],),
      ],
    );
  }
}
