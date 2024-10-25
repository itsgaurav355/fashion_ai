import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/common_dropdown.dart';
import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyleInfoScreen extends StatefulWidget {
  const StyleInfoScreen({super.key});

  @override
  State<StyleInfoScreen> createState() => _StyleInfoScreenState();
}

class _StyleInfoScreenState extends State<StyleInfoScreen> {
  Color _selectedColor = Colors.white;
  final TextEditingController _patternController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  List<String> selectedPatterns = [];
  List<String> patterns = [
    "Checks",
    "Stripes",
    "Polka Dots",
    "Florals",
    "Animal Prints",
    "Abstract Patterns",
    "Houndstooth",
    "Tartan",
    "Camouflage",
    "Paisley",
    "Damask",
    "Brocade",
    "Tie-Dye",
    "Chevron",
    "Argyle"
  ];
  String? _preferredStyle;
  String? _selectedBudget;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userController = Provider.of<UserProvider>(context, listen: false);
      _preferredStyle = userController.preferredStyle;
      _selectedColor = userController.color;
      _patternController.text = userController.pattern;
      _brandController.text = userController.brand;
      _selectedBudget = userController.budget;
    });
    super.initState();
  }

  @override
  void dispose() {
    _patternController.dispose();
    _sizeController.dispose();
    _brandController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Preferred Style*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MyDropDownButton(
                selectedItem: _preferredStyle,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _preferredStyle = value.toString();
                    });
                  }
                },
                items: const ["Casual", "Formal", "Traditional"],
                hint: "e.g. Select your preferred style",
              ),
              const SizedBox(height: 5),
              const Text(
                "Color*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _colorPicker(),
              const Text(
                "Pattern*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              MyDropDownButton(
                  hint: "Select Patterns you like",
                  items: patterns,
                  onChanged: (val) {
                    if (val != null &&
                        !selectedPatterns.contains(val.toString())) {
                      setState(() {
                        selectedPatterns.add(val.toString());
                      });
                    }
                  }),
              Wrap(
                spacing: 10,
                children: selectedPatterns
                    .map(
                      (e) => FilterChip(
                        label: Text(e),
                        selected: selectedPatterns.contains(e),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedPatterns.add(e);
                            } else {
                              selectedPatterns.remove(e);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 5),
              const Text(
                "Brands*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _brandController,
                hintText: "Brands name you like",
              ),
              const SizedBox(height: 5),
              const Text(
                "Budget*",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              MyDropDownButton(
                selectedItem: _selectedBudget,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedBudget = value.toString();
                    });
                  }
                },
                items: const [
                  "less than 10k",
                  "10k-20k",
                  "20k-30k",
                  "30k-40k",
                  "40k-50k",
                  "50k and above"
                ],
                hint: "Select you budget",
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          Consumer<UserProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: CommonButton(
            title: "Next",
            textColor: Colors.white,
            buttonColor: Colors.black,
            onPressed: () {
              //check if all fields are filled
              if (_preferredStyle == null ||
                  selectedPatterns.isEmpty ||
                  _brandController.text.isEmpty ||
                  _selectedBudget == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all the fields'),
                  ),
                );
                return;
              }
              value.updateStyleInfo(
                preferredStyle: _preferredStyle,
                color: _selectedColor,
                pattern: selectedPatterns.join(", "),
                brand: _brandController.text,
                budget: _selectedBudget,
              );
              value.incrementStep();
            },
            borderRadius: 10,
          ),
        );
      }),
    );
  }

  Widget _colorPicker() {
    return ListTile(
      title: const Text('Choose your favorite color'),
      subtitle: Text(
        'Color: ${_selectedColor.toString()}',
        style: TextStyle(
            color: _selectedColor.computeLuminance() > 0.5
                ? Colors.black
                : _selectedColor),
      ),
      trailing: GestureDetector(
        onTap: () async {
          // Store current color before we open the dialog.
          final Color colorBeforeDialog = _selectedColor;
          // Wait for the picker to close, if dialog was dismissed,
          // then restore the color we had before it was opened.
          if (!(await _colorPickerDialog())) {
            setState(() {
              _selectedColor = colorBeforeDialog;
            });
          }
        },
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Future<bool> _colorPickerDialog() async {
    Color tempColor = _selectedColor; // Temporary color to update
    // Show the color picker dialog
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose your outfit favourite color!',
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: tempColor,
              onColorChanged: (Color color) {
                tempColor = color; // Update the temp color
              },
              showColorCode: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                setState(() {
                  _selectedColor = tempColor; // Update selected color
                });
                Navigator.of(context).pop(true); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Close the dialog without changes
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Return false if dialog was dismissed
  }
}
