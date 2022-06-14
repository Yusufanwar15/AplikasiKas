import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

class Pengeluaran extends StatefulWidget {
  const Pengeluaran({Key? key}) : super(key: key);

  @override
  State<Pengeluaran> createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {
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
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pengeluaran = firestore.collection("pengeluaran");
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
            Container(
              margin: EdgeInsets.all(30),
              child: TextFormField(
                controller: datetimeinput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: jumlah,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Rp',
                  hintText: 'Tambahkan Jumlah',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, right: 30, left: 30),
              child: TextField(
                controller: keterangan,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Keterangan',
                  hintText: 'Tambahkan Keterangan',
                ),
              ),
            ),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 200, height: 40,
              child: ElevatedButton(
                onPressed: () {
                  pengeluaran.add({
                    'tgl' : datetimeinput.text,
                    'jumlah' : int.tryParse(jumlah.text) ?? 0,
                    'keterangan' : keterangan.text,
                  }
                  );

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
