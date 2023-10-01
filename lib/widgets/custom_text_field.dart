import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final TextInputType inputType;
  final int maxLength;
  //final int minLines;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final String labelText;
  final String? hintText;
  final Function? validator;
  //final bool isReadOnly;
  //final Function? tapFunction;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.maxLength = 127,
    required this.controller,
    this.validator,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.hintText,
    //this.minLines = 1,
    //this.isReadOnly = false,
    //this.tapFunction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //readOnly: widget.isReadOnly,
      //onTap: () => widget.tapFunction!(),
      maxLength: widget.maxLength,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      //minLines: widget.minLines,
      //maxLines: widget.minLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: '',
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
      ),
      validator: (value) => widget.validator!(value),
      controller: widget.controller,
    );
  }
}
