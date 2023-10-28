import 'dart:io';

import 'package:attendenceapp/Pages/Utils/filepicker.dart';
import 'package:attendenceapp/Pages/Utils/saveattendancedialog.dart';
import 'package:attendenceapp/Repository/Faculty/facecount.dart';
import 'package:attendenceapp/Repository/Faculty/takeattendance.dart';
import 'package:flutter/material.dart';

import '../Models/attendance.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage(
      {super.key, required this.dateOfLeaving, required this.department});
  final String dateOfLeaving;
  final String department;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<AttendanceModel> mapList;
  bool isLoading = true;
  File? _fileController;
  int? face_count;
  String? face_count_image;
  bool showloading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      takeAttendance(widget.dateOfLeaving, widget.department).then((value) {
        mapList = value;
        isLoading = false;
        setState(() {});
      });
    });
  }

  void onFilePick(File file) {
    setState(() {
      _fileController = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return SaveAttendanceDialog(
                    mapList: mapList,
                  );
                });
          }
          // Navigator.pop(context);
        },
        child: const Icon(Icons.done),
      ),
      appBar: AppBar(title: const Text("Attendance")),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Total: ${mapList.length}"),
                              Text(
                                  "Present: ${mapList.where((element) => element.isPresent).length}"),
                              Text(
                                  "Absent: ${mapList.where((element) => !element.isPresent).length}"),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    "Verify the students attendance by uploading the image of the class."),
                                FilePickerWidget(
                                  onFilePick: onFilePick,
                                ),
                                // showing the image
                                _fileController != null
                                    ? GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                        body: Center(
                                                            child: Image.file(
                                                                _fileController!)),
                                                      )))
                                        },
                                        child: Image.file(
                                          _fileController!,
                                          width: 100,
                                          height: 100,
                                        ),
                                      )
                                    : Container(),
                                // button to upload the image
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      showloading = true;
                                    });
                                    faceCount(_fileController!.path)
                                        .then((value) => {
                                              setState(() {
                                                face_count = value!.faceCount;
                                                face_count_image = value.image;
                                                showloading = false;
                                              }),
                                            });
                                  },
                                  child: Text("Upload"),
                                ),
                                // showing the face count and image
                                showloading
                                    ? CircularProgressIndicator()
                                    : face_count != null
                                        ? Text("Face Count: $face_count")
                                        : Container(),
                                !showloading &&
                                        face_count_image != null &&
                                        face_count_image!.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                        body: Center(
                                                            child: Image.network(
                                                                face_count_image!)),
                                                      )))
                                        },
                                        child: Image.network(
                                          face_count_image!,
                                          width: 100,
                                          height: 100,
                                        ),
                                      )
                                    : Container(),
                              ])
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: mapList.length,
                          itemBuilder: (context, idx) {
                            return AttendanceTile(
                              idx: idx,
                              tile: mapList[idx],
                              onTap: onTap,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  onTap(int idx) {
    setState(() {
      mapList[idx].changeStatus();
    });
  }
}

class AttendanceTile extends StatelessWidget {
  const AttendanceTile(
      {super.key, required this.idx, required this.onTap, required this.tile});

  final int idx;
  final AttendanceModel tile;
  final Function(int idx) onTap;

  @override
  Widget build(BuildContext context) {
    AttendanceModel student = tile;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.lightBlueAccent.withOpacity(0.6),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            Expanded(
              child: Center(
                child: Text(
                  student.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    student.isPresent ? Colors.green : Colors.red),
              ),
              onPressed: () {
                onTap(idx);
              },
              child: Text(student.isPresent ? "Present" : "Absent"),
            )
          ],
        ),
      ),
    );
  }
}
