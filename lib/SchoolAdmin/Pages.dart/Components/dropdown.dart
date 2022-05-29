import 'package:adminpannel/SchoolAdmin/providers/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  final Function(String?)? onchange;
  final List<String> items;
  const DropDown({Key? key, this.onchange, required this.items})
      : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var dropdownValue = 'Select';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              value: dropdownValue,
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                widget.onchange!(newValue);
                setState(() {
                  dropdownValue = newValue.toString();
                });
                print(newValue);
              },
            ),
          )),
    );
  }
}
