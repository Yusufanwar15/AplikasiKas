import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/anggota.dart';
import 'package:kas_app/screen/catat_transaksi.dart';
import 'package:kas_app/screen/login/home.dart';
import 'package:kas_app/screen/pemasukan.dart';
import 'package:kas_app/screen/pengeluaran.dart';
import 'package:kas_app/screen/tambah_anggota.dart';
import 'package:kas_app/screen/laporan.dart';



class dashboard_screen extends StatefulWidget {
  const dashboard_screen({Key? key}) : super(key: key);

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text('Buku Kas App'),
            actions: <Widget> [
              IconButton(
                icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                 
                 Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeScreen())
                 );
                    
                },
              )
            ],
          ),
            body: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 190),
                color: Colors.white,
              ),
              Container(
                margin: EdgeInsets.only(top: 120, left: 20, right: 20),
                height: 150,
                width: double.infinity,
                child: Card(
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
                        'Total Kas',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        'Rp.  ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 280,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      GridView(
                        padding: const EdgeInsets.all(18),
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 150,
                        ),
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
                                    builder: (_) => Anggota()));
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Laporan()));
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
                                    'Laporan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
