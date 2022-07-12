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

  getMasuk() {
    CollectionReference masuk = firestore.collection('pemasukan');

    return masuk.get();
  }
}

class _PemasukanState extends State<Pemasukan> {
  final _formkey = GlobalKey<FormState>();

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
              return Column(
                children: [
                  Expanded(child: bodyWidget(snapshot)),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    width: 300,
                    child: Card(
                      margin: EdgeInsets.only(bottom: 90),
                      elevation: 10,
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
                            ' Rp. $totalPemasukan',
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
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
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
                      'Pemasukan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
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
                            'Pilih Nama Anggota                                             '),
                        underline: Container(
                          padding: EdgeInsets.only(right: 30, left: 30),
                          height: 2,
                          width: double.infinity,
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
                  child: TextFormField(
                    controller: jumlahkas,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money_outlined),
                      // border: const OutlineInputBorder(),
                      labelText: 'Kas Anggota',
                      hintText: 'Jumlah Kas',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Jumlah Kas belum diisi!';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal belum dipilih';
                      }
                      return null;
                    },
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
                      if (_formkey.currentState!.validate()) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => Pemasukan()));
        
                        db.collection('pemasukan').add({
                          'nama': nama,
                          'jumlahkas': jumlah,
                          'tgl': datetimeinput.text,
                        });
                        showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                                  title: Text(
                                    'Data Berhasil Ditambahkan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ));
                      }
        
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
          ),
        ),
      );
}
