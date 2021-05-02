import 'package:flutter/material.dart';

class DropDownGenerator extends StatefulWidget {
  String dropdownValue;
  List<String> dropdownValues;
  String notAllowedValue;
  String dropDownNumber;
  String hintText = ' ';
  DropDownGenerator(
      {this.dropdownValue,
      this.dropdownValues,
      this.dropDownNumber,
      this.notAllowedValue,
      this.hintText});

  @override
  _DropDownGeneratorState createState() => _DropDownGeneratorState();
}

class _DropDownGeneratorState extends State<DropDownGenerator> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.dropdownValue,
      hint: Text(
        '${widget.hintText}',
        style: TextStyle(color: Colors.grey),
      ),
      iconDisabledColor: Colors.black54,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      // onChanged: (String newValue) {
      //   setState(() {
      //     widget.dropdownValue = newValue;
      //     if (widget.dropDownNumber == 'three') {
      //       Provider.of<NewDataByShipper>(context, listen: false).updateNoOfTrucks(newValue: newValue);
      //     } else if (widget.dropDownNumber == 'four') {
      //       Provider.of<NewDataByShipper>(context, listen: false).updateWeight(newValue: newValue);
      //     }
      //   });
      // },
      items:
          widget.dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//TODO: move this to new file DatePicker
class DatePickerGenerator extends StatelessWidget {
  final String date;
  DatePickerGenerator({this.date});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(
        '$date',
        style: TextStyle(color: Colors.grey),
      ),
      icon: Icon(Icons.date_range_outlined),
      iconDisabledColor: Colors.black54,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      items: [],
    );
  }
}
