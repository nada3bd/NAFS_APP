import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final Function(String)? onChanged;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isPatient;
  final DateTime? dateofbirth;
  final ScrollController? scrollController;
  const CustomTextField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.isPatient = false,
    this.dateofbirth,
    this.scrollController,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  String? errorText;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != controller.text) {
      controller.text = widget.value;
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();   
    super.dispose();
  }

  void validate(String value) {
    if (value.trim().isEmpty ||
        (value.trim().isEmpty )) {
      setState(() {
        errorText = "This field is required";
      });
    } else if (widget.label.toLowerCase() == 'email' && !_isValidEmail(value)) {
      setState(() {
        errorText = "Oops! Please enter a valid email address.";
      });
    } else {
      setState(() {
        errorText = null;
      });
    }
  }

  bool _isValidEmail(String value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    return emailRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xFFEEEEEE),
          cursorColor: Colors.black,
          selectionHandleColor: Colors.teal,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: (widget.readOnly && widget.label != "Gender" && widget.label != "Birthday")
                    ? InkWell(
                        onTap: widget.onTap,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            labelText: widget.label,
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(widget.icon, color: Colors.grey),
                            suffixText:
                                widget.label == "Price" ? " JD" : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorText != null
                                      ? Colors.red
                                      : const Color.fromRGBO(97, 97, 97, 1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorText != null
                                      ? Colors.red
                                      : Colors.teal),
                            ),
                          ),
                          isEmpty: controller.text.isEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              controller.text.isEmpty
                                  ? ''
                                  : controller.text,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.text.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : TextField(
                        controller: controller,
                        onEditingComplete: () {
                          widget.onChanged?.call(controller.text);
                          validate(controller.text);
                          focusNode.unfocus();
                        },
                        onChanged: (newValue) {
                          widget.onChanged?.call(newValue);
                          validate(newValue);
                        },
                        maxLines: widget.maxLines,
                        readOnly: widget.readOnly,
                        onTap: () {
                          if (widget.readOnly) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          } else {
                            widget.onTap?.call();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Scrollable.ensureVisible(
                                context,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                alignment: 0.1,
                              );
                            });
                          }
                        },
                        focusNode: focusNode,
                        inputFormatters: widget.label == "Price"
                            ? [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+(\.\d{0,2})?\$')),
                              ]
                            : [],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          labelText: widget.label,
                          labelStyle: TextStyle(
                            color: focusNode.hasFocus
                                ? Colors.teal
                                : const Color.fromRGBO(97, 97, 97, 1),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(widget.icon,
                              color:
                                  focusNode.hasFocus ? Colors.teal : Colors.grey),
                          suffixText:
                              widget.label == "Price" ? " JD" : null,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: errorText != null
                                    ? Colors.red
                                    : const Color.fromRGBO(97, 97, 97, 1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    errorText != null ? Colors.red : Colors.teal),
                          ),
                        ),
                      ),
              ),
              if (errorText != null)
                Positioned(
                  bottom: 4,
                  left: 16,
                  right: 16,
                  child: Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void validateExternally() {
    validate(controller.text);
  }
}
