import 'package:flutter/material.dart';

class AreaMeasurementResult {
  final double height;
  final double width;

  const AreaMeasurementResult({required this.height, required this.width});

  double get area => height * width;
}

class AreaMeasurementDialog extends StatefulWidget {
  const AreaMeasurementDialog({super.key});

  @override
  State<AreaMeasurementDialog> createState() => _AreaMeasurementDialogState();
}

class _AreaMeasurementDialogState extends State<AreaMeasurementDialog> {
  final heightController = TextEditingController();

  final widthController = TextEditingController();

  double area = 0;

  void calculate() {
    final height = double.tryParse(heightController.text) ?? 0;

    final width = double.tryParse(widthController.text) ?? 0;

    setState(() {
      area = height * width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Area Measurement'),

      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          TextField(
            controller: heightController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(labelText: 'Height'),

            onChanged: (_) => calculate(),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: widthController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(labelText: 'Width'),

            onChanged: (_) => calculate(),
          ),

          const SizedBox(height: 20),

          Text(
            'Area: '
            '${area.toStringAsFixed(2)} sqft',

            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: area <= 0
              ? null
              : () {
                  Navigator.pop(
                    context,

                    AreaMeasurementResult(
                      height: double.parse(heightController.text),

                      width: double.parse(widthController.text),
                    ),
                  );
                },

          child: const Text('Add'),
        ),
      ],
    );
  }
}
