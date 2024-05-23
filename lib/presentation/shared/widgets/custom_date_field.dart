import 'package:flutter/material.dart';


class CustomDateField extends StatefulWidget {
  final bool isTopField;
  final bool isBottomField;
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool enabled;
  final bool? icon;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomDateField({
    super.key,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.enabled = true,
    this.icon = true,
  });

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _dateController.text = widget.initialValue!;
      _selectedDate = DateTime.tryParse(widget.initialValue!);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _selectedDate!.toIso8601String().split('T').first;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_dateController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(15);
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: widget.isTopField ? borderRadius : Radius.zero,
          topRight: widget.isTopField ? borderRadius : Radius.zero,
          bottomLeft: widget.isBottomField ? borderRadius : Radius.zero,
          bottomRight: widget.isBottomField ? borderRadius : Radius.zero,
        ),
        boxShadow: [
          if (widget.isBottomField)
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: TextFormField(
        controller: _dateController,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        style: const TextStyle(fontSize: 15),
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          floatingLabelBehavior: widget.maxLines > 1 ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorMessage,
          focusColor: colors.primary,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}