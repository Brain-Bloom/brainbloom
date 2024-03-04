import 'package:flutter/material.dart';

class MyDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const MyDropdownField({
    Key? key,
    required this.hintText,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownFieldState createState() => _MyDropdownFieldState();
}

class _MyDropdownFieldState extends State<MyDropdownField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'Roboto',
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          value: _selectedItem,

        ),
      ),
    );
  }
}
