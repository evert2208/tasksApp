import 'package:flutter/material.dart';

class MessageFildBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageFildBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {

    final textController = TextEditingController();
    final focusNode = FocusNode();
    

  final outlineInputBorder = UnderlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(40)
  );

  final inputDecoration =  InputDecoration(
        hintText: '',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
        icon:  const Icon(Icons.send_outlined),
        onPressed: (){
          final textValue = textController.value.text;
          textController.clear();
          onValue(textValue);
        },
        ) 
      );

    return TextFormField(
      onTapOutside: (event){
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
     
    );
  }
}