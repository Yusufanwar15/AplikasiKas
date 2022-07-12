import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

final db = FirebaseFirestore.instance;

class FirebaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getMasuk() {
    CollectionReference masuk = firestore.collection('pemasukan');

    return masuk.get();
  }

  getPengeluaran() {
    CollectionReference keluar = firestore.collection('pengeluaran');

    return keluar.get();
  }
}

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
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
                Text(
                  'Laporan Keuangan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseController().getMasuk(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            // TODO: Handle this case.
                            break;
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            var dataPemasukan = snapshot.data?.docs;
                            var totalPemasukan = 0;
                            dataPemasukan?.forEach((data) {
                              totalPemasukan += int.parse(data['jumlahkas']);
                            });
                            print(totalPemasukan.toString());
                            return Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              width: 160,
                              height: 100,
                              child: Card(
                                elevation: 10,
                                color: Color(0xff26a69a),
                                // shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                    )),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Pemasukan',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ' Rp. $totalPemasukan',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          default:
                            return SizedBox();
                        }
                        return SizedBox();
                      },
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseController().getPengeluaran(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            // TODO: Handle this case.
                            break;
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            var dataPemasukan = snapshot.data?.docs;
                            var totalPengeluaran = 0;
                            dataPemasukan?.forEach((data) {
                              totalPengeluaran += int.parse(data['jumlah']);
                            });
                            print(totalPengeluaran.toString());
                            return Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              width: 160,
                              height: 100,
                              child: Card(
                                elevation: 10,
                                color: Colors.red,
                                // shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                    )),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Pengeluaran',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ' Rp. $totalPengeluaran',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          default:
                            return SizedBox();
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseController().getMasuk(),
              builder: (context, snapshot) {
                return Expanded(child: bodyWidget(snapshot));
              },
            ),
          ],
        ),
      ),
    );
  }

  bodyWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) =>
      SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: db.collection('pemasukan').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      physics: ScrollPhysics(parent: null),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    documentSnapshot['nama'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Kas :  ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  documentSnapshot['jumlahkas'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff26a69a),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  documentSnapshot['tgl'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                              onPressed: () {
                                // Here We Will Add The Delete Feature
                                db
                                    .collection('pemasukan')
                                    .doc(documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),
                        );
                      });
                }),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: db.collection('pengeluaran').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      physics: ScrollPhysics(parent: null),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return Container(
                          child: ListTile(
                            title: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    documentSnapshot['keterangan'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    documentSnapshot['tgl'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Uang Keluar =>  ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                                Text(
                                  documentSnapshot['jumlah'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                              onPressed: () {
                                // Here We Will Add The Delete Feature
                                db
                                    .collection('pengeluaran')
                                    .doc(documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),
                        );
                      });
                }),
                
          ],
        ),
      );
}
