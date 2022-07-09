import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/anggota.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

class TambahAnggota extends StatefulWidget {
  const TambahAnggota({Key? key}) : super(key: key);

  @override
  State<TambahAnggota> createState() => _TambahAnggotaState();
}

class _TambahAnggotaState extends State<TambahAnggota> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Anggota()));
                      },
                    ),
                  ),
                  Text('Tambah Anggota', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ],
              ),
              
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 20, end: 15),
                          child: Icon(Icons.person_outlined),
                        ),
                        hintText: "Nama",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 20, end: 15),
                          child: Icon(Icons.phone_android_outlined),
                        ),
                        hintText: "NoHp",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nohp tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ],
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
                          MaterialPageRoute(builder: (_) => Anggota()));

                      users.add({
                        'name': nameController.text,
                        'phone': int.tryParse(phoneController.text)
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
                    nameController.text = '';
                    phoneController.text = '';
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Simpan",
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
}
