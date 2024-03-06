import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final String? hint;
  final List<String> items;
  String? selectedItem;
  final bool hasError;
  final ValueChanged<String>? onChanged;

  MyDropdownButton({
    this.hint,
    required this.items,
    this.selectedItem,
    required this.hasError,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<MyDropdownButton> createState() => MyDropdownButtonState();
}

class MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.hasError ? Colors.red : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
        ),
        child: DropdownButton<String>(
          value: widget.selectedItem,
          hint: Text(
            widget.hint ?? "Select",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'Roboto',
            ),
          ),
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.selectedItem = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue!);
            }
          },
          underline: Container(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          focusColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01),
        ),
      ),
    );
  }
}
