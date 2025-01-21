// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
//
// class ContactSearch extends StatefulWidget {
//   @override
//   _ContactSearchState createState() => _ContactSearchState();
// }
//
// class _ContactSearchState extends State<ContactSearch> {
//   late Iterable<Contact> _contacts = [];
//   late Iterable<Contact> _filteredContacts = [];
//   TextEditingController _searchController = TextEditingController();
//   List<Contact> _selectedContacts = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchContacts();
//     _retrieveSelectedContacts();
//   }
//
//   Future<void> _fetchContacts() async {
//     Iterable<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts;
//       _filteredContacts = _contacts;
//     });
//   }
//
//   void _filterContacts(String query) {
//     setState(() {
//       _filteredContacts = _contacts.where((contact) =>
//           (contact.displayName ?? '').toLowerCase().contains(query.toLowerCase()));
//     });
//   }
//
//   Future<void> _retrieveSelectedContacts() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('selected_contacts').get();
//       List<Contact> selectedContacts = [];
//       querySnapshot.docs.forEach((doc) {
//         String displayName = doc['displayName'];
//         selectedContacts.add(Contact(displayName: displayName));
//       });
//       setState(() {
//         _selectedContacts = selectedContacts;
//       });
//     } catch (e) {
//       print('Error retrieving selected contacts from Firestore: $e');
//     }
//   }
//
//   void _addContact(Contact contact) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm'),
//           content: Text('Are you sure you want to add this contact?'),
//           actions: <Widget>[
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF4C2559),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//
//               child: Text('No',style:TextStyle(color:Colors.white)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 // backgroundColor: Colors.purple.shade50,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: Text('Yes',style:TextStyle(color:Color(0xFF4C2559))),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _addContactConfirmed(contact);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _addContactConfirmed(Contact contact) async {
//     setState(() {
//       if (!_selectedContacts.contains(contact)) {
//         _selectedContacts.add(contact);
//       }
//     });
//     try {
//       await FirebaseFirestore.instance.collection('selected_contacts').add({
//         'displayName': contact.displayName,
//       });
//
//       // Extracting the phone number of the selected contact
//       String? phoneNumber;
//       if (contact.phones != null && contact.phones!.isNotEmpty) {
//         phoneNumber = contact.phones!.first.value;
//       } else {
//         print('No phone number found for this contact');
//         return;
//       }
//
//       // Message to send
//       String pageUrl = "https://kavachraksha.page.link/6eZ4";
//       String message = "Hi, $phoneNumber. I'd like to add you as a friend. Please visit $pageUrl.";
//
//       // Launch SMS application with prefilled content
//       String uri = 'sms:$phoneNumber?body=$message';
//       if (await canLaunch(uri)) {
//         await launch(uri);
//       } else {
//         throw 'Could not launch $uri';
//       }
//     } catch (e) {
//       print('Error adding contact to Firestore or sending SMS: $e');
//     }
//   }
//
//
//   void _removeContact(Contact contact) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm'),
//           content: Text('Are you sure you want to remove this contact?'),
//           actions: <Widget>[
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF4C2559),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: Text('No',style:TextStyle(color:Colors.white)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 // backgroundColor: Colors.purple.shade50,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: Text('Yes',style:TextStyle(color:Color(0xFF4C2559))),
//               onPressed: () {
//                 _removeContactConfirmed(contact);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _removeContactConfirmed(Contact contact) async {
//     Navigator.of(context).pop(); // Dismiss the dialog
//     setState(() {
//       _selectedContacts.remove(contact);
//     });
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('selected_contacts')
//           .where('displayName', isEqualTo: contact.displayName)
//           .get();
//       querySnapshot.docs.forEach((doc) {
//         doc.reference.delete();
//       });
//     } catch (e) {
//       print('Error removing contact from Firestore: $e');
//     }
//   }
//
//   void _viewSelectedContacts() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SelectedContactsPage(
//           selectedContacts: _selectedContacts,
//           onRemoveContact: _removeContact,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           onChanged: _filterContacts,
//           decoration: InputDecoration(
//             hintText: 'Search Contacts...',
//             focusColor: Colors.black,
//           ),
//           cursorColor: Colors.black,
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: _filteredContacts != null
//           ? ListView.builder(
//         itemCount: _filteredContacts.length,
//         itemBuilder: (context, index) {
//           Contact contact = _filteredContacts.elementAt(index);
//           String firstLetter = contact.displayName != null && contact.displayName!.isNotEmpty
//               ? contact.displayName![0].toUpperCase()
//               : '';
//           return ListTile(
//             title: Text(contact.displayName ?? ''),
//             leading: CircleAvatar(
//               backgroundColor: _generateRandomColor(),
//               child: Text(firstLetter),
//             ),
//             onTap: () {
//               _addContact(contact);
//             },
//           );
//         },
//       )
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//       floatingActionButton: _selectedContacts.isNotEmpty
//           ? FloatingActionButton.extended(
//         onPressed: _viewSelectedContacts,
//         label: Text(
//           'View Friend list',
//           textAlign: TextAlign.center,
//         ),
//       )
//           : null,
//     );
//   }
//
//   Color _generateRandomColor() {
//     final random = Random();
//     return Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
//   }
// }
//
// class SelectedContactsPage extends StatefulWidget {
//   final List<Contact> selectedContacts;
//   final Function(Contact) onRemoveContact;
//
//   SelectedContactsPage({
//     required this.selectedContacts,
//     required this.onRemoveContact,
//   });
//
//   @override
//   _SelectedContactsPageState createState() => _SelectedContactsPageState();
// }
//
// class _SelectedContactsPageState extends State<SelectedContactsPage> {
//
//   void _removeContactConfirmed(Contact contact) {
//     // Navigator.of(context).pop(); // Dismiss the dialog
//     setState(() {
//       widget.selectedContacts.remove(contact);
//     });
//     widget.onRemoveContact(contact);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4C2559),
//         title: Text('Invite friends',style: TextStyle(color: Colors.white),),
//       ),
//       body: ListView.builder(
//         itemCount: widget.selectedContacts.length,
//         itemBuilder: (context, index) {
//           Contact contact = widget.selectedContacts[index];
//           String firstLetter = contact.displayName != null && contact.displayName!.isNotEmpty
//               ? contact.displayName![0].toUpperCase()
//               : '';
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Card(
//               color: Colors.grey.shade100,
//               child: ListTile(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 title: Text(contact.displayName ?? ''),
//                 leading: CircleAvatar(
//                   backgroundColor: _generateRandomColor(),
//                   child: Text(firstLetter),
//                 ),
//                 trailing: ElevatedButton(
//                   onPressed: (){
//                     _removeContactConfirmed(contact);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF4C2559),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Text('cancle invite',style:TextStyle(color:Colors.white)),
//                 ),
//                 // trailing: IconButton(
//                 //   icon: Icon(Icons.cancel),
//                 //   onPressed: () {
//                 //     _removeContactConfirmed(contact);
//                 //   },
//                 // ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Color _generateRandomColor() {
//     final random = Random();
//     return Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: ContactSearch(),
//   ));
// }
//
// /*class _ContactSearchState extends State<ContactSearch> {
//   late Iterable<Contact> _contacts = [];
//   late Iterable<Contact> _filteredContacts = [];
//   TextEditingController _searchController = TextEditingController();
//   List<Contact> _selectedContacts = [];
//
//   // Initialize FlutterLocalNotificationsPlugin
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//     _fetchContacts();
//     _retrieveSelectedContacts();
//   }
//
//   // Initialize notification plugin
//   void _initializeNotifications() {
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   // Display notification
//   Future<void> _showNotification(String title, String body) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high, ticker: 'ticker');
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics,
//         payload: 'item x');
//   }
//
//
// }*/
