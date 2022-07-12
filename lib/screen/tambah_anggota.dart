import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

class TambahAnggota extends StatefulWidget {
  const TambahAnggota({ Key? key }) : super(key: key);

  @override
  State<TambahAnggota> createState() => _TambahAnggotaState();
}

class _TambahAnggotaState extends State<TambahAnggota> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => dashboard_screen()));
                    },
                  ),
                ),
                Text(
                  'Tambah Anggota',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),
            // Container(
            //   child: Text(
            //     "Let's Get Started!",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold, fontSize: 30
            //     ),
            //   ),
            // ),

            // SizedBox(height: 5,),
            // Container(
            //   child: Text(
            //     "Create an account to Q Allure to get all features",
            //     style: TextStyle(
            //       fontSize: 14, color: Colors.grey
            //     ),
            //   ),
            // ),

            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, end: 15),
                        child: Icon(Icons.person_outlined),
                      ),
                      hintText: "Full Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),

                  SizedBox(height: 20,),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, end: 15),
                        child: Icon(Icons.phone_android_outlined),
                      ),
                      hintText: "Phone",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
                ),
            ),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 200, height: 40,
              child: ElevatedButton(
                onPressed: () {
                  users.add({
                    'name' : nameController.text,
                    'phone' : int.tryParse(phoneController.text) ?? 0
                  }
                  );

                  nameController.text = '';
                  phoneController.text = '';
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "CREATE",
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