import 'package:flutter/material.dart';

Card taskCard(
  BuildContext context,
  int index,
  String description,
  String priority,
  String date,
  List<Color> cardColor,
) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: cardColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 15.0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: richText(
                    "Priority :  ",
                    priority,
                  ),
                ),
                Expanded(
                  child: richText(
                    "Deadline :  ",
                    date,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

RichText richText(
  String tag,
  String data,
) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: tag,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: data,
        ),
      ],
    ),
  );
}
