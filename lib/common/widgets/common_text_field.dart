import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function? validator;
  final IconData? icon;
  final Function? onChanged;
  final Color? borderColor;
  final Icon? suffixIcon;
  final Function? onSuffixIconPressed;
  final int? maxLines;
  final bool isEmail;
  final String hintText;
  final Color? textColor;
  final TextInputFormatter? inputFormatter;
  final bool? obsecureText;
  final bool? isDisabled;
  final double? borderRadius;

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
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.textColor,
    this.borderRadius,
    this.isDisabled,
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
      enabled: widget.isDisabled != null ? !widget.isDisabled! : true,
      maxLines: widget.maxLines,
      controller: widget.controller,
      inputFormatters: widget.inputFormatter != null
          ? [widget.inputFormatter!]
          : [FilteringTextInputFormatter.deny(RegExp(r''))],
      mouseCursor: SystemMouseCursors.allScroll,
      style: TextStyle(
          color: widget.textColor ?? Colors.black,
          decoration: TextDecoration.none),
      obscureText: isHidden,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(.4),
          errorText: errorText,
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    if (widget.onSuffixIconPressed != null) {
                      widget.onSuffixIconPressed!();
                    }
                  },
                  icon: widget.suffixIcon!,
                )
              : widget.isDisabled != null && widget.isDisabled!
                  ? const Icon(Icons.stop_circle)
                  : null,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          // labelText: widget.hintText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.black),
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
          }
          // else if (val.isEmpty) {
          //   errorText = "This field is required";
          // }
          else if (widget.onChanged != null) {
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
