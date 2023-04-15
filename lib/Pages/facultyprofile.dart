import 'package:attendenceapp/Models/faculty.dart';
import 'package:flutter/material.dart';

class FacultyProfilePage extends StatelessWidget {
  final FacultyModel faculty;
  const FacultyProfilePage({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[400]!,
                  Colors.blue[800]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  faculty.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black.withOpacity(0.1),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            // contentPadding: EdgeInsets.symmetric(vertical: 20),
                            leading: const Icon(Icons.email),
                            title: const Text('Email'),
                            subtitle: Text(faculty.email),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: const Text('Phone'),
                            subtitle: Text(faculty.phone),
                          ),
                          ListTile(
                            leading: const Icon(Icons.work),
                            title: const Text('Department'),
                            subtitle: Text(faculty.department),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
