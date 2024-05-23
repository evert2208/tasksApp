import 'package:flutter/material.dart';

class OpenClosedCheckbox extends StatefulWidget {
  late bool estado;
  OpenClosedCheckbox({super.key, required this.estado});

  @override
  _OpenClosedCheckboxState createState() => _OpenClosedCheckboxState();
}

class _OpenClosedCheckboxState extends State<OpenClosedCheckbox> {
  // bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                  value: widget.estado,
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      setState(() {
                        widget.estado = true;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Cerrado'),
                  value: !widget.estado,
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      setState(() {
                        widget.estado = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}