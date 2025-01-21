


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_project/presentation/E-learning/video_model.dart';
import 'package:kavach_project/presentation/E-learning/ytPlayer.dart';

class videoList extends StatelessWidget {
  const videoList({super.key});

  // Future<List<videoModel>> readJsonData() async {
  //   final jsonData = await rootBundle.loadString('json_file/videoList.json');
  //   final list = json.decode(jsonData) as List<dynamic>;
  //
  //   return list.map((e) => videoModel.fromJson(e)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color(0xFF4C2659),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.05, // Adjust position as needed
              left: 15,
              right: 0,
              child: Text(
                'Chapters of E-Learning',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.88,
                  child: Center(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('elearning')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          // Display fetched data
                          List<DocumentSnapshot> videos = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> videoData =
                              videos[index].data() as Map<String, dynamic>;

                              String videoUrl = videoData['link'] ?? '';

                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/activist.png'), // Provide the path to your image
                                    ),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${videoData['name']}',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF4C2559)),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '$videoUrl',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => YT_Player(
                                            ytUrl: videoUrl,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}