import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Compose extends StatefulWidget {
  const Compose({Key key}) : super(key: key);

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final controllerName = TextEditingController();
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Compose',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: "Roboto"),
        ),
        actions: [
          PopupMenuButton<String>(
            offset: Offset(50, 40),
            icon: Icon(
              (Icons.attachment),
              color: Colors.grey[600],
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: '1',
                  child: Text('Attach File'),
                ),
                PopupMenuItem<String>(
                  value: '2',
                  child: Text('Insert From Drive'),
                ),
              ];
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
            color: Colors.grey[600],
          ),
          PopupMenuButton<String>(
              offset: Offset(50, 350),
              icon: Icon(
                (Icons.more_vert),
                color: Colors.grey[600],
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: '1',
                    child: Text('Schedule Send'),
                  ),
                  PopupMenuItem<String>(
                    value: '2',
                    child: Text('Add from contacts'),
                  ),
                  PopupMenuItem<String>(
                    value: '3',
                    child: Text('Discard'),
                  ),
                  PopupMenuItem<String>(
                    value: '4',
                    child: Text('Save Draft'),
                  ),
                  PopupMenuItem<String>(
                    value: '5',
                    child: Text('Settings'),
                  ),
                  PopupMenuItem<String>(
                    value: '6',
                    child: Text('Help & Feedback'),
                  ),
                ];
              },
              onSelected: (value) {}),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'Name', controller: controllerName),
            const SizedBox(
              height: 16,
            ),
            buildTextField(title: 'Email', controller: controllerTo),
            const SizedBox(
              height: 16,
            ),
            buildTextField(title: 'Subject', controller: controllerSubject),
            const SizedBox(
              height: 16,
            ),
            buildTextField(
              title: 'Message',
              controller: controllerMessage,
              maxLines: 8,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () => sendEmail(
                name: controllerName.text,
                toEmail: controllerTo.text,
                subject: controllerSubject.text,
                message: controllerMessage.text,
              ),
              child: Text('SEND'),
            ),
          ],
        ),
      ),
    );
  }

  Future sendEmail({
    String name,
    String toEmail,
    String subject,
    String message,
  }) async {
    final serviceId = 'service_noa9l0b';
    final templateId = 'template_o2b2ajx';
    final userId = '9pZ7NUi3bOKVGcEXB';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': toEmail,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
  }
}

Widget buildTextField({
  String title,
  TextEditingController controller,
  int maxLines = 1,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(border: OutlineInputBorder()),
        )
      ],
    );
