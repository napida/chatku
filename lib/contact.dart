import 'package:flutter/material.dart';

class Contact {
  String name;
  String img;

  Contact(this.name, this.img);

  static final List<Contact> member = [
    Contact('Snit Sanghlao', 'image/avatar.jpg'),
    Contact('Paveena Hongitthiporn', 'image/avatar.jpg'),
    Contact('Napida Chongcharoenkit', 'image/avatar.jpg')
  ];

  List<Contact> get contact => member;
}

class ContactModel with ChangeNotifier {
  final List<Contact> _addedContact = [];

  void addcontact(Contact contact) {
    _addedContact.add(contact);
    notifyListeners();
  }

  void removecontact(Contact contact) {
    _addedContact.remove(contact);
    notifyListeners();
  }

  //getter added contact.
  List<Contact> get contact => _addedContact;
}
