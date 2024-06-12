import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/models/quiz_model.dart';
import 'package:settings_page/views/widgets/custom_quiz_maker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoScreen extends StatefulWidget {
  final Course course;
  final int index;

  const YouTubeVideoScreen(
      {super.key, required this.course, required this.index});

  @override
  State<YouTubeVideoScreen> createState() => _YouTubeVideoScreenState();
}

class _YouTubeVideoScreenState extends State<YouTubeVideoScreen> {
  late YoutubePlayerController _controller;
  late List<Quiz> quiz;

  @override
  void initState() {
    super.initState();
    String initialVideoId = YoutubePlayer.convertUrlToId(
            widget.course.courseLessons[widget.index].videoUrl) ??
        '';
    _controller = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    quiz = widget.course.courseLessons[widget.index].lessonQuiz;
    selectedOptions = List<String?>.filled(quiz.length, null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late List<String?> selectedOptions;

  void updateSelectedOption({required int index, required String? option}) {
    selectedOptions[index] = option;
    setState(() {});
  }

  void checkAnswers() {
    int correctAnswers = 0;
    for (int i = 0; i < quiz.length; i++) {
      if (selectedOptions[i] == quiz[i].qOptions[quiz[i].qCorrectAnswer]) {
        correctAnswers++;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You got $correctAnswers out of ${quiz.length}'),
            if (correctAnswers == quiz.length)
              const Text('Congratulations, you are genius'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson video'),
        backgroundColor: Colors.amber,
        centerTitle: false,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: ListView.builder(
                itemCount: quiz.length,
                itemBuilder: (context, index) => CustomQuizMaker(
                  question: quiz[index].qQuestion,
                  answer: quiz[index].qCorrectAnswer,
                  options: quiz[index].qOptions,
                  onOptionSelected: (String? value) => updateSelectedOption(
                    index: index,
                    option: value,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: checkAnswers,
            child: const Text('Check answer'),
          ),
        ],
      ),
    );
  }
}
