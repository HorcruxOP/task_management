import 'package:flutter/material.dart';

class SelectDateAndTime extends StatelessWidget {
  final Function(DateTime?) dateSelect;
  final Function(TimeOfDay?) timeSelect;
  const SelectDateAndTime(
      {super.key, required this.dateSelect, required this.timeSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            var selectDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            dateSelect(selectDate);
          },
          child: const Text("Select date"),
        ),
        const SizedBox(width: 10),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            var selectTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            timeSelect(selectTime);
          },
          child: const Text("Select time"),
        ),
      ],
    );
  }
}
