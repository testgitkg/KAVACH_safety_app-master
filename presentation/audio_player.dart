// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
//
// class RecordingPage extends StatefulWidget {
//   final String audioFilePath;
//
//   const RecordingPage({Key? key, required this.audioFilePath}) : super(key: key);
//
//   @override
//   _RecordingPageState createState() => _RecordingPageState();
// }
//
// class _RecordingPageState extends State<RecordingPage> {
//   late AudioPlayer _audioPlayer;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _playAudio();
//   }
//
//   Future<void> _playAudio() async {
//     int result = await _audioPlayer.play(widget.audioFilePath, isLocal: true);
//     if (result == 1) {
//       // success
//       print('Audio playing');
//     } else {
//       // failure
//       print('Error playing audio');
//     }
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recording'),
//       ),
//       body: Center(
//         child: Text('Recording Playing...'),
//       ),
//     );
//   }
// }
