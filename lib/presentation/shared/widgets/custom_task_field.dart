import 'package:flutter/material.dart';


class CustomTaskField extends StatelessWidget {

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

  const CustomTaskField({
    super.key, 
    this.isTopField = false, 
    this.isBottomField = false, 
    this.label, 
    this.hint, 
    this.errorMessage, 
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.initialValue = '',
    this.onChanged, 
    this.onFieldSubmitted, 
    this.validator,
    this.enabled= true,
    this.icon=true
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40)
    );

    const borderRadius = Radius.circular(15);

    return Container(
      padding: const EdgeInsets.only(bottom: 8 ),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: isTopField ? borderRadius : Radius.zero, 
          topRight: isTopField ? borderRadius : Radius.zero, 
          bottomLeft: isBottomField ? borderRadius : Radius.zero,
          bottomRight: isBottomField ? borderRadius : Radius.zero,
        ),
        boxShadow: [
          if (isBottomField)
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 5,
              offset: const Offset(0,3)
            )
        ]
      ),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle( fontSize: 15 ),
        maxLines: maxLines,
        initialValue: initialValue,
        decoration: InputDecoration(
          floatingLabelBehavior: maxLines > 1 ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 15),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
          focusedErrorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          icon: icon != null && icon==true ? const Icon( Icons.check, color: Colors.green) : null,
        ),
      ),
    );
  }
}