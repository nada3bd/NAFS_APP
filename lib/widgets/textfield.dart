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
    if (value.trim().isEmpty) {
      setState(() {
        errorText = "This field is required";
      });
    } else if (widget.label.toLowerCase() == 'email' &&
        !_isValidEmail(value)) {
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
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: theme.brightness == Brightness.light
                      ? const Color(0xFFF5F5F5) 
                      : colorScheme.surface, 
                ),
                child: (widget.readOnly &&
                        widget.label != "Gender" &&
                        widget.label != "Birthday")
                    ? InkWell(
                        onTap: widget.onTap,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            labelText: widget.label,
                            labelStyle: TextStyle(
                              color: theme.hintColor,
                              fontSize: 14,
                            ),
                            prefixIcon:
                                Icon(widget.icon, color: theme.hintColor),
                            suffixText:
                                widget.label == "Price" ? " JD" : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: errorText != null
                                      ? Colors.red
                                      : theme.dividerColor),
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
                              controller.text.isEmpty ? '' : controller.text,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.text.isEmpty
                                    ? theme.hintColor
                                    : theme.textTheme.bodyMedium!.color,
                              ),
                            ),
                          ),
                        ),
                      )
                    : TextField(
                        controller: controller,
                        cursorColor: Colors.black,
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
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.bodyMedium!.color,
                        ),
                        inputFormatters: widget.label == "Price"
                            ? [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.\d{0,2})?$'),
                                ),
                              ]
                            : [],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          labelText: widget.label,
                          labelStyle: TextStyle(
                            color: focusNode.hasFocus
                                ? Colors.teal
                                : theme.hintColor,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            widget.icon,
                            color: focusNode.hasFocus
                                ? Colors.teal
                                : theme.hintColor,
                          ),
                          suffixText:
                              widget.label == "Price" ? " JD" : null,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorText != null
                                  ? Colors.red
                                  : theme.dividerColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorText != null
                                  ? Colors.red
                                  : Colors.teal,
                            ),
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
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
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
