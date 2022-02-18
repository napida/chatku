import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}

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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Friend'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contact = context.watch<ContactModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend'),
        backgroundColor: Colors.teal,
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
          )),
    );
  }
}
