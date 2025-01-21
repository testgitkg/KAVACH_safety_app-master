//
//
//
// import 'dart:math';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<User?> signInAnonymously() async {
//     try {
//       UserCredential result = await _auth.signInAnonymously();
//       User? user = result.user;
//       return user;
//     } catch (e) {
//       print("Error signing in anonymously: $e");
//       return null;
//     }
//   }
//
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//
// class ContactManager {
//   final CollectionReference contactCollection =
//   FirebaseFirestore.instance.collection('contacts');
//
//   Future<void> addContact(
//       String userId, String displayName, String phoneNumber) async {
//     try {
//       DocumentReference docRef = contactCollection.doc(userId);
//       DocumentSnapshot doc = await docRef.get();
//       if (doc.exists) {
//         await docRef.update({
//           'contacts': FieldValue.arrayUnion([
//             {'displayName': displayName, 'phoneNumber': phoneNumber}
//           ])
//         });
//       } else {
//         await docRef.set({
//           'contacts': [
//             {'displayName': displayName, 'phoneNumber': phoneNumber}
//           ]
//         });
//       }
//     } catch (e) {
//       print("Error adding contact: $e");
//     }
//   }
//
//   Future<void> removeContact(String userId, String displayName) async {
//     try {
//       DocumentReference docRef = contactCollection.doc(userId);
//       DocumentSnapshot doc = await docRef.get();
//       if (doc.exists) {
//         List<dynamic> contacts = doc['contacts'];
//         contacts.removeWhere(
//                 (contactData) => contactData['displayName'] == displayName);
//         await docRef.update({'contacts': contacts});
//       }
//     } catch (e) {
//       print("Error removing contact: $e");
//     }
//   }
//
//   Stream<DocumentSnapshot> getUserContacts(String userId) {
//     return contactCollection.doc(userId).snapshots();
//   }
// }
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
//   final ContactManager _contactManager = ContactManager();
//   bool _isLoading = true; // Added
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchContacts();
//     _fetchSelectedContacts();
//   }
//
//   Future<void> _fetchContacts() async {
//     Iterable<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts;
//       _filteredContacts = _contacts;
//       _isLoading = false; // Updated
//     });
//   }
//
//   Future<void> _fetchSelectedContacts() async {
//     String userId = AuthService().getCurrentUser()?.uid ?? '';
//     if (userId.isNotEmpty) {
//       Stream<DocumentSnapshot> snapshot =
//       _contactManager.getUserContacts(userId);
//       snapshot.listen((DocumentSnapshot document) {
//         setState(() {
//           _selectedContacts.clear();
//           if (document.exists) {
//             List<dynamic> contacts = document['contacts'];
//             contacts.forEach((contactData) {
//               String displayName = contactData['displayName'];
//               String phoneNumber = contactData['phoneNumber'];
//               Contact contact = Contact(
//                 displayName: displayName,
//                 phones: [Item(label: 'mobile', value: phoneNumber)],
//               );
//               _selectedContacts.add(contact);
//             });
//           }
//         });
//       });
//     }
//   }
//
//   void _filterContacts(String query) {
//     setState(() {
//       _filteredContacts = _contacts.where((contact) =>
//           (contact.displayName ?? '')
//               .toLowerCase()
//               .contains(query.toLowerCase()));
//     });
//   }
//
//   void _showAddContactDialog(Contact contact) async {
//     if (_selectedContacts.contains(contact)) {
//       // If the contact is already selected, show an alert dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Contact Already Added'),
//             content: Text(
//                 '${contact.displayName} is already in your selected contacts.'),
//             actions: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF4C2559),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // If the contact is not selected, show confirmation dialog to add
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Add Contact'),
//             content: Text('Do you want to add ${contact.displayName}?'),
//             actions: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                   ),
//
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//                 child: Text('No',style: TextStyle(color: Color(0xFF4C2559)),),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF4C2559),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                   ),
//
//                 ),
//                 onPressed: () {
//                   _addContact(contact);
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//                 child: Text('Yes'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   void _addContact(Contact contact) async {
//     String userId = AuthService().getCurrentUser()?.uid ?? '';
//     if (userId.isNotEmpty) {
//       _contactManager.addContact(
//         userId,
//         contact.displayName ?? '',
//         contact.phones?.first.value ?? '',
//       );
//       setState(() {
//         _selectedContacts.add(contact);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextFormField(
//           style: TextStyle(color: Colors.black),
//           controller: _searchController,
//           onChanged: _filterContacts,
//           decoration: InputDecoration(
//             hintText: 'Search Contacts...',
//           ),
//         ),
//       ),
//       body: _isLoading // Updated
//           ? Center(child: CircularProgressIndicator()) // Updated
//           : ListView.builder(
//         itemCount: _filteredContacts.length,
//         itemBuilder: (context, index) {
//           Contact contact = _filteredContacts.elementAt(index);
//           String firstLetter = contact.displayName != null &&
//               contact.displayName!.isNotEmpty
//               ? contact.displayName![0].toUpperCase()
//               : '';
//           return ListTile(
//             title: Text(contact.displayName ?? ''),
//             leading: CircleAvatar(
//               backgroundColor: _generateRandomColor(),
//               child: Text(firstLetter),
//             ),
//             onTap: () {
//               _showAddContactDialog(contact);
//             },
//           );
//         },
//       ),
//       floatingActionButton: _selectedContacts.isNotEmpty
//           ? FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SelectedContactsPage(
//                 selectedContacts: _selectedContacts,
//               ),
//             ),
//           );
//         },
//         label: Text(
//           'Add SOS Contacts',
//           textAlign: TextAlign.center,
//         ),
//       )
//           : null,
//     );
//   }
//
//   Color _generateRandomColor() {
//     final random = Random();
//     return Color.fromRGBO(
//         random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
//   }
// }
//
// class SelectedContactsPage extends StatefulWidget {
//   final List<Contact> selectedContacts;
//
//   SelectedContactsPage({
//     required this.selectedContacts,
//   });
//
//   @override
//   _SelectedContactsPageState createState() =>_SelectedContactsPageState();
// }
//
// class _SelectedContactsPageState extends State<SelectedContactsPage> {
//   late List<Contact> _selectedContacts;
//   final ContactManager _contactManager = ContactManager();
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedContacts = widget.selectedContacts;
//   }
//
//   void _removeContact(Contact contact) async {
//     String userId = AuthService().getCurrentUser()?.uid ?? '';
//     if (userId.isNotEmpty) {
//       _contactManager.removeContact(userId, contact.displayName ?? '');
//       setState(() {
//         _selectedContacts.remove(contact);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Selected Contacts'),
//       ),
//       body: ListView.builder(
//         itemCount: _selectedContacts.length,
//         itemBuilder: (context, index) {
//           Contact contact = _selectedContacts[index];
//           String firstLetter = contact.displayName != null &&
//               contact.displayName!.isNotEmpty
//               ? contact.displayName![0].toUpperCase()
//               : '';
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Card(
//               color: Colors.grey.shade100,
//               child: ListTile(
//                 contentPadding:
//                 EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 title: Text(contact.displayName ?? ''),
//                 subtitle: Text(contact.phones?.isNotEmpty ?? false
//                     ? contact.phones!.first.value ?? 'No phone number'
//                     : 'No phone number'),
//                 leading: CircleAvatar(
//                   backgroundColor: _generateRandomColor(),
//                   child: Text(firstLetter),
//                 ),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     _showRemoveContactDialog(context, contact);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child:
//                   Text('Remove', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _showRemoveContactDialog(
//       BuildContext context, Contact contact) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Remove Contact'),
//           content: Text('Do you want to remove ${contact.displayName}?'),
//           actions: <Widget>[
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text('No',style: TextStyle(color: Color(0xFF4C2559)),),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF4C2559),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                 ),
//               ),
//               onPressed: () {
//                 _removeContact(contact);
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Color _generateRandomColor() {
//     final random = Random();
//     return Color.fromRGBO(
//         random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
//   }
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   AuthService().signInAnonymously();
//   runApp(MaterialApp(
//     home: ContactSearch(),
//   ));
// }
//


import 'dart:math';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class ContactManager {
  final CollectionReference contactCollection =
  FirebaseFirestore.instance.collection('contacts');

  Future<void> addContact(
      String userId, String displayName, String phoneNumber) async {
    try {
      DocumentReference docRef = contactCollection.doc(userId);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        await docRef.update({
          'contacts': FieldValue.arrayUnion([
            {'displayName': displayName, 'phoneNumber': phoneNumber}
          ])
        });
      } else {
        await docRef.set({
          'contacts': [
            {'displayName': displayName, 'phoneNumber': phoneNumber}
          ]
        });
      }
    } catch (e) {
      print("Error adding contact: $e");
    }
  }

  Future<void> removeContact(String userId, String displayName) async {
    try {
      DocumentReference docRef = contactCollection.doc(userId);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        List<dynamic> contacts = doc['contacts'];
        contacts.removeWhere((contactData) =>
        contactData['displayName'] == displayName);
        await docRef.update({'contacts': contacts});
      }
    } catch (e) {
      print("Error removing contact: $e");
    }
  }

  Stream<DocumentSnapshot> getUserContacts(String userId) {
    return contactCollection.doc(userId).snapshots();
  }
}

class ContactSearch extends StatefulWidget {
  @override
  _ContactSearchState createState() => _ContactSearchState();
}

class _ContactSearchState extends State<ContactSearch> {
  late Iterable<Contact> _contacts = [];
  late Iterable<Contact> _filteredContacts = [];
  TextEditingController _searchController = TextEditingController();
  List<Contact> _selectedContacts = [];
  bool _isLoading = true;
  final ContactManager _contactManager = ContactManager();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _fetchContacts();
    _fetchSelectedContacts();

  }

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _filteredContacts = _contacts;
      _isLoading = false; // Updated
    });
  }




  Future<void> _fetchSelectedContacts() async {
    String userId = AuthService().getCurrentUser()?.uid ?? '';
    if (userId.isNotEmpty) {
      Stream<DocumentSnapshot> snapshot = _contactManager.getUserContacts(userId);
      snapshot.listen((DocumentSnapshot document) {
        setState(() {
          _selectedContacts.clear();
          if (document.exists) {
            List<dynamic> contacts = document['contacts'];
            contacts.forEach((contactData) {
              String displayName = contactData['displayName'];
              String phoneNumber = contactData['phoneNumber'];
              Contact contact = Contact(
                displayName: displayName,
                phones: [Item(label: 'mobile', value: phoneNumber)],
              );
              _selectedContacts.add(contact);
            });
          }
        });
      });
    }
  }

  void _filterContacts(String query) {
    setState(() {
      _filteredContacts = _contacts.where((contact) =>
          (contact.displayName ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()));
    });
  }



  // void _addContact(Contact contact) async {
  //   String userId = AuthService().getCurrentUser()?.uid ?? '';
  //   if (userId.isNotEmpty) {
  //     _contactManager.addContact(
  //       userId,
  //       contact.displayName ?? '',
  //       contact.phones?.first.value ?? '',
  //     );
  //     setState(() {
  //       _selectedContacts.add(contact);
  //     });
  //   }
  // }
  // void _addContact(Contact contact) async {
  //   String userId = AuthService().getCurrentUser()?.uid ?? '';
  //   if (userId.isNotEmpty) {
  //     bool contactExists = _selectedContacts.any((selectedContact) =>
  //     selectedContact.displayName == contact.displayName &&
  //         selectedContact.phones?.first.value == contact.phones?.first.value);
  //
  //     if (contactExists) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Duplicate Contact'),
  //             content: Text('This contact is already added to SOS contacts.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(); // Close dialog
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       _contactManager.addContact(
  //         userId,
  //         contact.displayName ?? '',
  //         contact.phones?.first.value ?? '',
  //       );
  //       setState(() {
  //         _selectedContacts.add(contact);
  //       });
  //     }
  //   }
  // }
  BuildContext? _addContactDialogContext; // Declare a variable to hold dialog context

  Future<void> _showAddContactDialog(Contact contact) async {
    _addContactDialogContext = context; // Store the dialog context
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Text('Do you want to add ${contact.displayName}?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('No',style: TextStyle(color:Color(0xFF4C2559),),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C2559),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                _addContact(contact);

              },
              child: Text('Yes',style: TextStyle(color:Colors.white,),
              ),
            ),],
        );
      },
    );
  }
  // BuildContext? _addContactDialogContext;
  void _addContact(Contact contact) async {
    String userId = AuthService().getCurrentUser()?.uid ?? '';
    if (userId.isNotEmpty) {
      bool contactExists = _selectedContacts.any((selectedContact) =>
      selectedContact.displayName == contact.displayName &&
          selectedContact.phones?.first.value == contact.phones?.first.value);

      if (contactExists) {
        showDialog(
          context: _addContactDialogContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Duplicate Contact'),
              content: Text('This contact is already added to SOS contacts.'),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4C2559),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(_addContactDialogContext!).pop();// Close dialog
                  },
                  child: Text('OK',style: TextStyle(color: Colors.white),),
                ),
              ],
            );
          },
        );
      } else {
        _contactManager.addContact(
          userId,
          contact.displayName ?? '',
          contact.phones?.first.value ?? '',
        );
        setState(() {
          _selectedContacts.add(contact);
        });
        Navigator.of(_addContactDialogContext!).pop(); // Close Add Contact dialog
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          onChanged: _filterContacts,
          decoration: InputDecoration(

            hintText: 'Search Contacts...',

            //focusColor: Colors.black,

          ),
        ),
      ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          :_filteredContacts != null
          ? ListView.builder(
        itemCount: _filteredContacts.length,
        itemBuilder: (context, index) {
          Contact contact = _filteredContacts.elementAt(index);
          String firstLetter = contact.displayName != null &&
              contact.displayName!.isNotEmpty
              ? contact.displayName![0].toUpperCase()
              : '';
          return ListTile(
            title: Text(contact.displayName ?? ''),
            leading: CircleAvatar(
              backgroundColor: _generateRandomColor(),
              child: Text(firstLetter),
            ),
            onTap: () {
              _showAddContactDialog(contact);
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: _selectedContacts.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedContactsPage(
                selectedContacts: _selectedContacts,
              ),
            ),
          );
        },
        label: Text(
          'Add SOS Contacts',
          textAlign: TextAlign.center,
        ),
      )
          : null,
    );
  }

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
  }
}



class SelectedContactsPage extends StatefulWidget {
  final List<Contact> selectedContacts;

  SelectedContactsPage({
    required this.selectedContacts,
  });

  @override
  _SelectedContactsPageState createState() => _SelectedContactsPageState();
}

class _SelectedContactsPageState extends State<SelectedContactsPage> {
  late List<Contact> _selectedContacts;
  final ContactManager _contactManager = ContactManager();

  @override
  void initState() {
    super.initState();
    _selectedContacts = widget.selectedContacts;
  }

  void _removeContact(Contact contact) async {
    String userId = AuthService().getCurrentUser()?.uid ?? '';
    if (userId.isNotEmpty) {
      _contactManager.removeContact(userId, contact.displayName ?? '');
      setState(() {
        _selectedContacts.remove(contact);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Contacts'),
      ),
      body: ListView.builder(
        itemCount: _selectedContacts.length,
        itemBuilder: (context, index) {
          Contact contact = _selectedContacts[index];
          String firstLetter = contact.displayName != null &&
              contact.displayName!.isNotEmpty
              ? contact.displayName![0].toUpperCase()
              : '';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Card(
              color: Colors.grey.shade100,
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                title: Text(contact.displayName ?? ''),
                subtitle: Text(contact.phones?.isNotEmpty ?? false
                    ? contact.phones!.first.value ?? 'No phone number'
                    : 'No phone number'),
                leading: CircleAvatar(
                  backgroundColor: _generateRandomColor(),
                  child: Text(firstLetter),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showRemoveContactDialog(context, contact);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text('Remove', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showRemoveContactDialog(
      BuildContext context, Contact contact) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Contact'),
          content: Text('Do you want to remove ${contact.displayName}?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('No',style: TextStyle(color: Color(0xFF4C2559),),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C2559),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                _removeContact(contact);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Yes',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService().signInAnonymously();
  runApp(MaterialApp(
    home: ContactSearch(),
  ));
}