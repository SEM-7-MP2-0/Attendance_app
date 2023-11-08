import 'package:attendenceapp/Models/faculty.dart';
import 'package:flutter/material.dart';
import 'package:attendenceapp/Pages/defaulterlist.dart';

import '../Repository/Faculty/myprofile.dart';

class defaulterpage extends StatelessWidget {
  const defaulterpage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Defaulter List Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notification icon button functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Defaulter List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              items: <String>[
                'SE IT',
                'TE IT',
                'BE IT',
                // Add your class items here
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select class'),
              onChanged: (String? value) {
                // Add your class dropdown onChanged logic here
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              items: <String>[
                'Batch 1',
                'Batch 2',
                'Batch 3',
                // Add your batch items here
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select batch'),
              onChanged: (String? value) {
                // Add your batch dropdown onChanged logic here
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Date start'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Date end'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefaulterListPage()),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
