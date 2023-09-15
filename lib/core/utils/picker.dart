import 'package:flutter/material.dart';

mixin Pickers<T extends StatefulWidget> on State<T> {
  CalendarDatePicker buildCalendarDatePicker(
    DateTime selectedDate,
  ) {
    selectedDate = DateTime.now();
    return CalendarDatePicker(
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      onDateChanged: (value) {
        // _selectedDate = value;
        if (selectedDate != null && value != selectedDate) {
          setState(() {
            selectedDate = value;
          });
        }
      },
    );
  }
}
