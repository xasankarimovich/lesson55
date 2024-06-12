import 'package:flutter/material.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  int doneTodo = 0;
  int unDoneTodo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoViewModel.countDoneTodo().then(
      (value) {
        doneTodo = value['done'] ?? 0;
        unDoneTodo = value['undone'] ?? 0;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      '$doneTodo',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.grey),
                    ),
                    const Text(
                      'Done todos',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    Text(
                      '$unDoneTodo',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.grey),
                    ),
                    const Text(
                      'Undone todos',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
