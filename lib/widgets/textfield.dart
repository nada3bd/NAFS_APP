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
  final DateTime? dateOfBirth;
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
    this.dateOfBirth,
    this.scrollController,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validate(String value) {
    if (value.trim().isEmpty && widget.label == 'Session Time') {
      setState(() {
        _errorText = "This field is required";
      });
    } else if (widget.label.toLowerCase() == 'email' && !_isValidEmail(value)) {
      setState(() {
        _errorText = "Oops! Please enter a valid email address.";
      });
    } else {
      setState(() {
        _errorText = null;
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
                child: TextField(
                  controller: _controller,
                  onEditingComplete: () {
                    widget.onChanged?.call(_controller.text);
                    _validate(_controller.text);
                    _focusNode.unfocus();
                  },
                  onChanged: (newValue) {
                    widget.onChanged?.call(newValue);
                    _validate(newValue);
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
                  focusNode: _focusNode,
                  inputFormatters: widget.label == "Price"
                      ? [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+(\.\d{0,2})?$')),
                        ]
                      : [],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      color: _focusNode.hasFocus
                          ? Colors.teal
                          : const Color.fromRGBO(97, 97, 97, 1),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(widget.icon,
                        color: _focusNode.hasFocus ? Colors.teal : Colors.grey),
                    suffixText: widget.label == "Price" ? " JD" : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _errorText != null
                              ? Colors.red
                              : const Color.fromRGBO(97, 97, 97, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _errorText != null ? Colors.red : Colors.teal),
                    ),
                  ),
                ),
              ),
              if (_errorText != null)
                Positioned(
                  bottom: 4,
                  left: 16,
                  right: 16,
                  child: Text(
                    _errorText!,
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
    _validate(_controller.text);
  }
}
