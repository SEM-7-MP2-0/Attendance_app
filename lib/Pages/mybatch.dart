import 'package:attendenceapp/Models/faculty.dart';
import 'package:flutter/material.dart';

import '../Repository/Faculty/myprofile.dart';

class MyBatchesPage extends StatefulWidget {
  const MyBatchesPage({super.key});
  @override
  _MyBatchesPageState createState() => _MyBatchesPageState();
}

class _MyBatchesPageState extends State<MyBatchesPage> {
  List<String> yourBatchList = [
    'Batch A',
    'Batch B',
    'Batch C',
    'Batch D',
    'Batch E',
  ];

  void addBatch(String batchName) {
    setState(() {
      yourBatchList.add(batchName);
    });
  }

  void deleteBatch(String batchName) {
    setState(() {
      yourBatchList.remove(batchName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Batches'),
      ),
      body: ListView.builder(
        itemCount: yourBatchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(yourBatchList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteBatch(yourBatchList[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBatchPage(addBatch),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddBatchPage extends StatefulWidget {
  final Function(String) addBatch;

  AddBatchPage(this.addBatch);

  @override
  _AddBatchPageState createState() => _AddBatchPageState();
}

class _AddBatchPageState extends State<AddBatchPage> {
  String batchName = '';
  List<String> prnList = [
    '120A3027',
    '120A3038',
    '120A3043',
    '120A3046',
    '120A3058'
  ];
  List<bool> addedList = List.filled(5, false);
  int addedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Batch'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Batch Name'),
              onChanged: (value) {
                setState(() {
                  batchName = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter PRN'),
              onChanged: (value) {
                // Add your PRN search logic here
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: prnList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(prnList[index]),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return addedList[index] ? Colors.red : Colors.green;
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          addedList[index] = !addedList[index];
                          addedList[index] ? addedCount++ : addedCount--;
                        });
                      },
                      child: Text(addedList[index] ? 'Remove' : 'Add'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  _showDialog(context, batchName, addedCount);
                },
                child: Icon(Icons.check),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String batchName, int addedCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Batch Creation'),
          content: Text(
              'Do you want to create batch $batchName with $addedCount PRNs?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                widget.addBatch(batchName);
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Batch created successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
