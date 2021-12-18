import 'package:flutter/material.dart';
import 'package:open_market/api/contact_api.dart';
import 'package:open_market/model/contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test firestore"),
      ),
      body: StreamBuilder<List<Contact>>(
          stream: ContactApi().getContacts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Contact contact = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.avatar),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phone),
                  );
                });
          }),
    );
  }
}
