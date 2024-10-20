import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final bool? isEnabled;
  final ValueChanged<String?> onChanged;
  final String Function(String?)? validator;
  final Color? dropdownColor;
  final Icon? icon;
  final Color? textColor;
  final Color? iconColor;
  final Color? underlineColor;

  const MyDropDownButton({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.validator,
    this.selectedItem,
    this.dropdownColor,
    this.textColor,
    this.iconColor,
    this.underlineColor,
    this.icon,
    this.isEnabled,
  });

  @override
  MyDropDownState createState() => MyDropDownState();
}

class MyDropDownState extends State<MyDropDownButton> {
  String? selectedItem;
  String? errorText;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  void _validateSelection() {
    if (selectedItem == null) {
      errorText = 'This field is required';
    } else {
      errorText = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      enabled: true,
      validator: widget.validator ??
          (value) {
            _validateSelection();
            return errorText; // Return the error text if there's an error
          },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputDecorator(
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                // Constants.borderColor.withOpacity(.4),
                prefixIcon: widget.icon,
                errorText: state.hasError ? state.errorText : null,
              ),
              isEmpty: selectedItem == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: selectedItem,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: widget.iconColor ?? Colors.blue,
                  ),
                  hint: Text(
                    widget.hint,
                    style: TextStyle(color: widget.textColor ?? Colors.black),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: widget.textColor ?? Colors.black, fontSize: 16),
                  onChanged: (String? item) {
                    setState(() {
                      selectedItem = item;
                      state.didChange(item);
                      _validateSelection(); // Validate after selection
                    });
                    widget.onChanged(item);
                  },
                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontSize: 16,
                            color: widget.textColor ?? Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // if (state.hasError || errorText != null)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 12.0, top: 5.0),
            //     child: Text(
            //       errorText ?? state.errorText!,
            //       style:
            //           const TextStyle(color: Colors.redAccent, fontSize: 12.0),
            //     ),
            //   ),
          ],
        );
      },
    );
  }
}
