import 'package:flutter/material.dart';

class CustomQuizMaker extends StatefulWidget {
  final String question;
  final int answer;
  final List<String> options;
  final ValueChanged<String?> onOptionSelected;

  const CustomQuizMaker({
    super.key,
    required this.question,
    required this.answer,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<CustomQuizMaker> createState() => _CustomQuizMakerState();
}

class _CustomQuizMakerState extends State<CustomQuizMaker> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text('Questions: ${widget.question}'),
          const Text('Options'),
          for (int i = 0; i < widget.options.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: widget.options[i],
                  groupValue: selectedOption,
                  onChanged: (value) {
                    selectedOption = value;
                    widget.onOptionSelected(value);
                    setState(() {});
                  },
                ),
                Text(widget.options[i]),
              ],
            ),
        ],
      ),
    );
  }
}
