import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
  final DateTime? initialValue;
  final DateTime? fechaInicio;
  final Function(DateTime) onChanged;
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
    required this.fechaInicio,
    required this.onChanged,
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
  

 @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(widget.initialValue!);
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
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: widget.fechaInicio ?? DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
         _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      widget.onChanged(picked);
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
        // onChanged: widget.onChanged,
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
          icon: widget.icon != null && widget.icon==true ? const Icon( Icons.check, color: Colors.green) : null,
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}