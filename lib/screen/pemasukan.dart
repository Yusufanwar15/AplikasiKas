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

class _PemasukanState extends State<Pemasukan> {
  TextEditingController datetimeinput = TextEditingController();
  TextEditingController jumlahkas = TextEditingController();
  
  Future<List<QueryDocumentSnapshot>> getAnggota() async {
    var firebaseUser = await db.collection("users").get();
    return firebaseUser.docs;
  }

  String nama = "";
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    datetimeinput.text = "";
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pemasukan = firestore.collection("pemasukan");
    return Scaffold(
      body: SafeArea(
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
            SizedBox(height: 50,),
            FutureBuilder(
              future: getAnggota(),
              builder: (conctext,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DropdownButton(
                    disabledHint:Text("Disabled"),
                    hint: Text('Pilih Nama Anggota                                         '),
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
            // StreamBuilder(
            //     stream: db.collection('kas').snapshots(),
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (!snapshot.hasData) {
            //         const Text("Loading.....");
            //       } else {
            //         List<DropdownMenuItem> currencyItems = [];
            //         for (int i = 0; i < snapshot.data?.docs.length; i++) {
            //           DocumentSnapshot snap = snapshot.data.docs[i];
            //           currencyItems.add(
            //             DropdownMenuItem(
            //               child: Text(
            //                 (snap['nama']),
            //                 style: TextStyle(color: Color(0xff11b719)),
            //               ),
            //               value: Text(snap['nama']),
            //             ),
            //           );
            //         }
            //       }
            //     },
            //   ),
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
             SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 200, height: 40,
              child: ElevatedButton(
                onPressed: () {
                  db.collection('pemasukan').add({
                    'nama' : nama,
                    'jumlahkas' : jumlah,
                    'tgl' : datetimeinput.text,
                    
                  }
                  );

                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => dashboard_screen()));
                  
                  datetimeinput.text = '';
                  jumlahkas.text="";
                  nama='';
                  
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "SIMPAN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
