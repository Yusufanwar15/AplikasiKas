import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/anggota.dart';
import 'package:kas_app/screen/catat_transaksi.dart';
import 'package:kas_app/screen/pemasukan.dart';
import 'package:kas_app/screen/pengeluaran.dart';
import 'package:kas_app/screen/tambah_anggota.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({Key? key}) : super(key: key);

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          // alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Total Kas',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // Text('hai dude'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 190),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(''),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 120,left: 20, right: 20),
              height: 150,
              child: Card(
                elevation: 15,
                color: Colors.white,
                // shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    )),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Pemasukan()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'images/bank.png',
                      //   height: 50,
                      //   width: 50,
                      // ),
                      Text(
                        'Total Kas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 280),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 30,
                        mainAxisExtent: 150,
                      ),
                      padding: EdgeInsets.all(15),
                      children: [
                        Card(
                          elevation: 15,
                          color: Colors.white,
                          // shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              )),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Pemasukan()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/bank.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  'Pemasukan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 15,
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white10.withOpacity(0.5),
                              )),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Pengeluaran()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/cash.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  'Pengeluaran',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        // Card(
                        //   elevation: 15,
                        //   color: Colors.white,
                        //   shadowColor: Colors.black,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       side: BorderSide(
                        //         color: Colors.white10.withOpacity(0.5),
                        //       )),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.of(context).push(
                        //           MaterialPageRoute(builder: (_) => TambahAnggota()));
                        //     },
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset('images/add.png', height: 50, width: 50,),
                        //         Text(
                        //           'Tambah Anggota',
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Card(
                          elevation: 15,
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white10.withOpacity(0.5),
                              )),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => Anggota()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/member.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  'Anggota',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 15,
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white10.withOpacity(0.5),
                              )),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => CatatTransaksi()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/lap.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Text(
                                  'Laporan Keuangan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Card(
                        //   elevation: 15,
                        //   color: Colors.white,
                        //   shadowColor: Colors.black,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       side: BorderSide(
                        //         color: Colors.white10.withOpacity(0.5),
                        //       )),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.of(context).push(
                        //           MaterialPageRoute(builder: (_) => CatatTransaksi()));
                        //     },
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset('images/transaksi.png', width: 50, height: 50,),
                        //         Text(
                        //           'Catat Transaksi',
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
