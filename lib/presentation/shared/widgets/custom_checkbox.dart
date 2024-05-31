import 'package:flutter/material.dart';

class OpenClosedCheckbox extends StatelessWidget {
  final Function(bool)? onChanged;
  late bool estado;
  final String taskId;
  OpenClosedCheckbox({super.key, required this.estado, required this.taskId, this.onChanged});

  // bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estado:',
            style: TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Abierto'),
                  value: estado,
                  enabled: taskId=='new' ?false : true,
                  onChanged: onChanged,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Cerrado'),
                  value: !estado,
                  enabled: taskId=='new' ?false : true,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
}