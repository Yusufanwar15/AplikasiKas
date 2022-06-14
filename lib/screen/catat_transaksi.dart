import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

final db = FirebaseFirestore.instance;
CollectionReference kas = db.collection('kas');
String? jml_input;

class CatatTransaksi extends StatefulWidget {
  const CatatTransaksi({Key? key}) : super(key: key);

  @override
  State<CatatTransaksi> createState() => _CatatTransaksiState();
}

class _CatatTransaksiState extends State<CatatTransaksi> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       Container(
      //         alignment: Alignment.centerLeft,
      //         child: IconButton(
      //           icon: Icon(Icons.arrow_back),
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => dashboard_screen()));
      //           },
      //         ),
      //       ),
      //       Container(
      //           alignment: Alignment.centerLeft,
      //           margin: EdgeInsets.all(15),
      //           child: Row(
      //             children: [
      //               Icon(Icons.add_circle_outline_rounded, size: 40),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Text(
      //                 'Tambah Transaksi',
      //                 style:
      //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //               ),
      //             ],
      //           )),
      //       Container(
      //         color: Color.fromARGB(255, 178, 178, 178),
      //         height: 1,
      //       ),
      //       Container(
      //         child: Column(
      //           children: [
      //             Text('Jenis Kasnya Apaa?'),
      //             Container(
      //           padding: const EdgeInsets.all(20),
      //           child: Column(
      //             children: [
      //               TextField(
      //                 decoration: InputDecoration(
      //                   border: const OutlineInputBorder(),
      //                   labelText: 'Rp',
      //                   hintText: 'Tambahkan Jumlah',
      //                 ),
      //                 onChanged: (String input) {
      //                   // Storing the value of the text entered in the variable value.
      //                   jml_input = input;
      //                 },
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: <Widget>[
      //                   OutlinedButton(
      //                     onPressed: () {
      //                       db.collection('kas').add({
      //                         'masuk': jml_input,
      //                         'keluar': '-',
      //                       });
      //                       // Navigator.of(context).push(MaterialPageRoute(builder: (_) => CatatTransaksi()));
      //                     },
      //                     child: const Text(
      //                       'Masuk',
      //                       style: TextStyle(
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                     style: OutlinedButton.styleFrom(
      //                       shape: const RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.all(Radius.circular(0)),
      //                       ),
      //                     ),
      //                   ),
      //                   OutlinedButton(
      //                     onPressed: () {
      //                       db.collection('kas').add({
      //                         'masuk': '-',
      //                         'keluar': jml_input,
      //                       });
      //                       // Navigator.of(context).push(MaterialPageRoute(builder: (_) => CatatTransaksi()));
      //                     },
      //                     child: const Text(
      //                       'Keluar',
      //                       style: TextStyle(
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                     style: OutlinedButton.styleFrom(
      //                       shape: const RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.all(Radius.circular(0)),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}