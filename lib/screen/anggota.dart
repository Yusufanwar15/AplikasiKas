import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/dashboard_screen.dart';
import 'package:kas_app/screen/tambah_anggota.dart';

final db = FirebaseFirestore.instance;

class Anggota extends StatefulWidget {
  const Anggota({Key? key}) : super(key: key);

  @override
  State<Anggota> createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          // When the User clicks on the button, display a BottomSheet
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TambahAnggota()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 19,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dashboard_screen()));
                },
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  StreamBuilder(
                      stream: db.collection('users').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, int index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.docs[index];
                              return ListTile(
                                title: Text(documentSnapshot['name']),
                                subtitle:
                                    Text(documentSnapshot['phone'].toString()),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                  ),
                                  onPressed: () {
                                    // Here We Will Add The Delete Feature
                                    db
                                        .collection('users')
                                        .doc(documentSnapshot.id)
                                        .delete();
                                  },
                                ),
                              );
                            });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
