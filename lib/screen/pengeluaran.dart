import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

final db = FirebaseFirestore.instance;
String? jumlahku;

class Pengeluaran extends StatefulWidget {
  const Pengeluaran({Key? key}) : super(key: key);

  @override
  State<Pengeluaran> createState() => _PengeluaranState();
}

class FirebaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getPengeluaran() {
    CollectionReference keluar = firestore.collection('pengeluaran');

    return keluar.get();
  }
}

class _PengeluaranState extends State<Pengeluaran> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController datetimeinput = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController jumlah = TextEditingController();
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
        future: FirebaseController().getPengeluaran(),
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
                totalPengeluaran += int.parse(data['jumlah']);
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
                            'Total Pengeluaran',
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

  bodyWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) => SafeArea(
        child: Form(
          key: _formKey,
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
              Container(
                margin: EdgeInsets.all(30),
                child: TextFormField(
                  controller: datetimeinput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: jumlah,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Rp',
                    hintText: 'Tambahkan Jumlah',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jumlah uang tidak boleh kosong!';
                    }
                    return null;
                  },
                  onChanged: (String jml) {
                    // Storing the value of the text entered in the variable value.
                    jumlahku = jml;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: 30, left: 30),
                child: TextFormField(
                  controller: keterangan,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Keterangan',
                    hintText: 'Tambahkan Keterangan',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Keterangan tidak boleh kosong!';
                    }
                    return null;
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => Pengeluaran()));

                      db.collection('pengeluaran').add({
                        'tgl': datetimeinput.text,
                        'jumlah': jumlah.text,
                        'keterangan': keterangan.text,
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
                    jumlah.text = '';
                    keterangan.text = '';
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
      );
}
