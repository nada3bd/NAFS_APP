import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? value;
  final IconData icon;
  final Function(String)? onChanged;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isPatient;
  final DateTime? dateofbirth;
  final ScrollController? scrollController;
  final bool isPassword;
  final TextEditingController? controller;


  const CustomTextField({
    super.key,
    required this.label,
    this.value,
    required this.icon,
    required this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.isPatient = false,
    this.dateofbirth,
    this.scrollController,
    this.isPassword = false, 
    this.controller, 
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  String? errorText;
  bool _obscureText = true; 


  @override
void initState() {
  super.initState();
  controller = widget.controller ?? TextEditingController(text: widget.value ?? '');
  focusNode = FocusNode();
}

@override
void didUpdateWidget(covariant CustomTextField oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.controller == null && widget.value != controller.text) {
    controller.text = widget.value ?? '';
    controller.selection = TextSelection.collapsed(offset: controller.text.length);
  }
}

@override
void dispose() {
  if (widget.controller == null) {
    controller.dispose();
  }
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
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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
                child: TextField(
                  controller: controller,
                  obscureText: widget.isPassword ? _obscureText : false,
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
                      color:
                          focusNode.hasFocus ? Colors.teal : theme.hintColor,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      widget.icon,
                      color:
                          focusNode.hasFocus ? Colors.teal : theme.hintColor,
                    ),
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: focusNode.hasFocus
                                  ? Colors.teal
                                  : theme.hintColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: errorText != null
                            ? Colors.red
                            : theme.dividerColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            errorText != null ? Colors.red : Colors.teal,
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
