
import 'package:chatku/navbar.dart';
import 'package:flutter/material.dart';
import 'contact.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: _ContactList(),
              ),
            ),
            /// ElevatedButton(
            ///   onPressed: () {
            ///     Navigator.pushNamed(context, '/friend');
            ///   },
            ///   child: const Text('Friend'),
            /// ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
      itemCount: Contact.member.length,
      itemBuilder: (context, index) => Row(
        children: [
          _AddImg(contact: Contact.member[index].img),
          _AddName(contact: Contact.member[index].name),
          _AddButton(contact: Contact.member[index]),
        ],
      ),
    );
  }
}
class _AddImg extends StatelessWidget {
  final String contact;
  const _AddImg({required this.contact, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:
    Image.asset(
      contact,
      height: 30,
    ));
  }
}

class _AddName extends StatelessWidget {
  final String contact;
  const _AddName({required this.contact, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(contact));
  }
}

class _AddButton extends StatelessWidget {
  final Contact contact;
  const _AddButton({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isAdded = context.select<ContactModel, bool>(
          (contact) => contact.contact.contains(this.contact),
    );
    return TextButton(
        onPressed: isAdded? null : () {
          context.read<ContactModel>().addcontact(this.contact);
        },
        child: isAdded
            ? const Icon(Icons.check, semanticLabel: 'ADDED')
            : const Text('ADD'));
  }
}
