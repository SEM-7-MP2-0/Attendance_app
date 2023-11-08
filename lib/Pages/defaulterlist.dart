import 'package:attendenceapp/Models/faculty.dart';
import 'package:flutter/material.dart';

import '../Repository/Faculty/myprofile.dart';

class DefaulterListPage extends StatelessWidget {
  const DefaulterListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Subject',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Total Lectures',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('AIDS II')),
                    DataCell(Text('30')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add delete row functionality here
                      },
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('IOE')),
                    DataCell(Text('25')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add delete row functionality here
                      },
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('STQA')),
                    DataCell(Text('27')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add delete row functionality here
                      },
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('AR VR')),
                    DataCell(Text('21')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add delete row functionality here
                      },
                    )),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('MIS')),
                    DataCell(Text('25')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add delete row functionality here
                      },
                    )),
                  ],
                ),
                // Add more DataRow widgets for additional rows
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your download list button logic here
              },
              child: Text('Download List'),
            ),
          ],
        ),
      ),
    );
  }
}
