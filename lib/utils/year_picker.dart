import 'package:flutter/material.dart';

class YearPickerWidget extends StatefulWidget {
  final int startYear;
  final int endYear;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final Function(int?) onYearChanged;

  YearPickerWidget({
    required this.startYear,
    required this.endYear,
    this.width,
    this.padding,
    this.border,
    required this.onYearChanged,
  });

  @override
  _YearPickerWidgetState createState() => _YearPickerWidgetState();
}

class _YearPickerWidgetState extends State<YearPickerWidget> {
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    List<int> years = List<int>.generate(
      widget.endYear - widget.startYear + 1,
          (index) => widget.startYear + index,
    );

    return Container(
      width: widget.width,
     padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: widget.border ?? Border.all(
          color: Colors.grey,
          width: 0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedYear,
          hint: Text('Select Year'),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          items: years.map((int year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              _selectedYear = newValue;
            });
            widget.onYearChanged(newValue);
          },
        ),
      ),
    );
  }
}
