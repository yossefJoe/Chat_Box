import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    this.controller,
    this.validator,
    this.hintText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final List<String> _savedEmails = [];
  List<String> _filteredEmails = [];
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword;
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
        if (!widget.isPassword) {
          final email = _controller.text.trim();
          if (_isValidEmail(email) && !_savedEmails.contains(email)) {
            setState(() {
              _savedEmails.add(email);
            });
          }
        }
      } else {
        if (!widget.isPassword) {
          _showOverlay();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.isPassword) return; // no suggestions for password

    final input = _controller.text.toLowerCase();
    setState(() {
      _filteredEmails = _savedEmails
          .where((email) => email.toLowerCase().startsWith(input) && input.isNotEmpty)
          .toList();
    });
    if (_filteredEmails.isNotEmpty && _focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 48),
          child: Material(
            elevation: 4,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredEmails.length,
              itemBuilder: (context, index) {
                final email = _filteredEmails[index];
                return ListTile(
                  title: Text(email),
                  onTap: () {
                    _controller.text = email;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: email.length),
                    );
                    _removeOverlay();
                    _focusNode.unfocus();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    overlay?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        validator: widget.validator,
        keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText ?? (widget.isPassword ? 'Enter your password' : 'Enter your email'),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: _toggleObscure,
                )
              : null,
        ),
      ),
    );
  }
}
