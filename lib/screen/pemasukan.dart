import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dashboard_screen.dart';

final db = FirebaseFirestore.instance;
String? jumlah;

class Pemasukan extends StatefulWidget {
  const Pemasukan({Key? key}) : super(key: key);

  @override
  State<Pemasukan> createState() => _PemasukanState();
}

class FirebaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getJurnal() {
    CollectionReference jurnal = firestore.collection('pemasukan');

    return jurnal.get();
  }
}

class _PemasukanState extends State<Pemasukan> {
  TextEditingController datetimeinput = TextEditingController();
  TextEditingController jumlahkas = TextEditingController();

  Future<List<QueryDocumentSnapshot>> getAnggota() async {
    var firebaseUser = await db.collection("users").get();
    return firebaseUser.docs;
  }

  String? nama = null;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    datetimeinput.text = "";
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseController().getJurnal(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              var dataPengeluaran = snapshot.data?.docs;
              var totalPengeluaran = 0;
              dataPengeluaran?.forEach((data) {
                totalPengeluaran += int.parse(data['jumlahkas']);
              });
              print(totalPengeluaran.toString());
              return Column(
                children: [
                  Expanded(child: bodyWidget(snapshot)),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 230,
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.only(bottom: 90),
                      elevation: 15,
                      color: Colors.white,
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
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Text(
                            ' Rp. $totalPengeluaran',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            default:
              return SizedBox();
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget bodyWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) => SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
              future: getAnggota(),
              builder: (conctext,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                // return CircularProgressIndicator();

                if (snapshot.connectionState == ConnectionState.done) {
                  //   print(snapshot.data);
                  return DropdownButton(
                    disabledHint: Text("Disabled"),
                    hint: Text(
                        'Pilih Nama Anggota                                         '),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    items: [
                      for (var data in snapshot.data!)
                        DropdownMenuItem(
                          child: Text(data.get("name")),
                          value: data.get("name"),
                        ),
                    ],
                    value: nama,
                    onChanged: (selected) {
                      setState(() {
                        nama =
                            selected?.toString() ?? "Anggota Tidak diketahui";
                      });
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30, right: 30, left: 30),
              child: TextField(
                controller: jumlahkas,
                decoration: InputDecoration(
                  // border: const OutlineInputBorder(),
                  labelText: 'Kas Anggota',
                  hintText: 'Jumlah Kas',
                ),
                onChanged: (String jml) {
                  // Storing the value of the text entered in the variable value.
                  jumlah = jml;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: TextFormField(
                controller: datetimeinput,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: "Enter Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030));
                  if (pickedDate != null) {
                    String formatDate =
                        DateFormat('dd-MMMM-yyyy').format(pickedDate);
                    setState(() {
                      datetimeinput.text = formatDate;
                    });
                  } else {
                    print("Date tidak dipilih");
                    datetimeinput.text = "";
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  db.collection('pemasukan').add({
                    'nama': nama,
                    'jumlahkas': jumlah,
                    'tgl': datetimeinput.text,
                  });

                  datetimeinput.text = '';
                  jumlahkas.text = "";
                  nama = '';
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "SIMPAN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      );
}
