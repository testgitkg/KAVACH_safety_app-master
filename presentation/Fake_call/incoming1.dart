import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kavach_project/presentation/home_page/home_page.dart';

class AcceptedCallScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String imagePath;

  AcceptedCallScreen({
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
  });

  @override
  _AcceptedCallScreenState createState() => _AcceptedCallScreenState();
}

class _AcceptedCallScreenState extends State<AcceptedCallScreen> {
  late Timer _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(widget.imagePath)),
                ),
                SizedBox(height: 30),
                Text(
                  ' ${widget.name}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  '${widget.phoneNumber}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 30),
                Text(
                  ' ${_formatTimer(_secondsElapsed)}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your record functionality here
                          },
                          icon: Icon(Icons.record_voice_over, color: Colors.white),
                        ),
                        Text('Record', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your video functionality here
                          },
                          icon: Icon(Icons.video_call, color: Colors.white),
                        ),
                        Text('Video', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your add call functionality here
                          },
                          icon: Icon(Icons.add_call, color: Colors.white),
                        ),
                        Text('Add Call', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your speaker functionality here
                          },
                          icon: Icon(Icons.speaker_phone, color: Colors.white),
                        ),
                        Text('Speaker', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your dialpad functionality here
                          },
                          icon: Icon(Icons.dialpad, color: Colors.white),
                        ),
                        Text('Dialpad', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your mute functionality here
                          },
                          icon: Icon(Icons.mic_off, color: Colors.white),
                        ),
                        Text('Mute', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.call_end),
              ),
            ),
          ),
        ],
      ),
    );
  }
}