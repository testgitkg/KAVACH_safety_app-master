import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'fale_call_details.dart';
import 'incoming1.dart';

class FakeCallScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String imagePath;
  //inal String iconPath; // Add icon path

  FakeCallScreen({
    required this.name,
    required this.phoneNumber,
    required this.imagePath,
    // required this.iconPath, // Initialize icon path
  });

  @override
  _FakeCallScreenState createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playRingtone();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playRingtone() async {
    try {
      await audioPlayer.setAsset('assets/rington.mp3');
      await audioPlayer.play();
    } catch (e) {
      print('Failed to play the ringtone: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Stack(
              alignment: Alignment.center,
              children: [
                if (widget.imagePath.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 30.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white54, width: 30.0),
                      ),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: FileImage(File(widget.imagePath)),
                      ),
                    ),
                  ),
                // if (widget.imagePath.isEmpty && widget.iconPath.isNotEmpty) // Check if imagePath is empty and iconPath is not empty
                Container(
                  width: 100,
                  height: 100,

                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              '${widget.name}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 700, left: 60),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(color: Colors.grey, width: 4.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>FakeCallDetails()));
                        audioPlayer.dispose();
                      },
                      child: Icon(
                        Icons.call_end,
                        size: 50,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Decline',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 700, right: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.grey, width: 4.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcceptedCallScreen(
                              name: widget.name,
                              imagePath: widget.imagePath,
                              phoneNumber: widget.phoneNumber,
                            ),
                          ),
                        );
                        audioPlayer.dispose();
                      },

                      child: Icon(
                        Icons.phone,
                        size: 50,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}