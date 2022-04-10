
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navbar.dart';
import 'contact.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contact = context.watch<ContactModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addfriend');
                },
                child: Icon(
                    Icons.person_add
                ),
              )
          )
        ],
      ),
      body: Container(
          child: ListView.builder(
            itemCount: contact.contact.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(contact.contact[index].name),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  contact.removecontact(contact.contact[index]);
                },
              ),
            ),
          )
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
