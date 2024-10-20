import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function? validator;
  final IconData? icon;
  final Function? onChanged;
  final Color? borderColor;
  final int? maxLines;
  final bool isEmail;
  final String hintText;
  final TextInputFormatter? inputFormatter;
  final bool? obsecureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsecureText = false,
    this.validator,
    this.isEmail = false,
    this.inputFormatter,
    this.icon,
    this.borderColor,
    this.maxLines,
    this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? errorText;
  bool isHidden = true;

  @override
  void initState() {
    isHidden = widget.obsecureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      inputFormatters: widget.inputFormatter != null
          ? [widget.inputFormatter!]
          : [FilteringTextInputFormatter.deny(RegExp(r''))],
      mouseCursor: SystemMouseCursors.allScroll,
      style:
          const TextStyle(color: Colors.black, decoration: TextDecoration.none),
      obscureText: isHidden,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(.2),
          errorText: errorText,
          suffixIcon: widget.obsecureText == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                      isHidden == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blue),
                )
              : null,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.grey..withOpacity(.3),
                )
              : null),
      onChanged: (val) {
        setState(() {
          if (widget.isEmail) {
            bool regEx = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val);
            if (!regEx) {
              errorText = "Please enter a valid email";
            } else {
              errorText = null;
            }
          } else if (widget.obsecureText == true && val.length < 6) {
            errorText = "Password must be at least 6 characters";
          } else if (val.isEmpty) {
            errorText = "This field is required";
          } else if (widget.onChanged != null) {
            widget.onChanged!(val);
          } else {
            errorText = null;
          }
        });
      },
      validator: (val) {
        if (widget.validator != null) {
          return widget.validator!(val);
        }
        if (val == null || val.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }
}
