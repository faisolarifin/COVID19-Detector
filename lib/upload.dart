import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'deteksi.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  late File uploadimage; //variable for choosed file
  late String namafile = "";

  Future<void> chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(choosedimage!.path);
    setState(() {
      uploadimage = file;
      namafile = choosedimage.name;
    });
  }

  Future<void> uploadImage() async {

    var url = Uri.parse("http://128.199.123.43/service");
    try{
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      Map data = {
        'msg' : 'success',
        'img' : baseimage,
      };
      //encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeteksiPage(image: uploadimage, data: jsondata,)));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent.withOpacity(80.0),
          content: Text("Error during connection to server!"),
        ));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent.withOpacity(80.0),
        content: Text("HTTPConnectionPool to backend server is failure!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 245.0,
            decoration: BoxDecoration(
                color: Color(0xFF28A3C1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90.0),
                    bottomRight: Radius.circular(90.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 22.0,),
                Text("Program Pendeteksi \nCovid-19 Pada Citra \nX-ray Dada ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.4,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                  "Berbasis CNN-LSTM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),

          ),
          Container(
            transform: Matrix4.translationValues(0.0, -60.0, 0.0),
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width - 64.0,
            height: 208.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: -2,
                  blurRadius: 25,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pilih Citra X-ray Dada",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            chooseImage();
                          },

                          child: Text(
                            "Browse..",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),)
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                              namafile != "" ? namafile : "No file selected.",
                          ),
                        ),
                        height: 35.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          border: Border.all(color: Color(0xFFF3F3F3))
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text(
                        "PROSES",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF36B1AB),
                      onPrimary: Colors.white,
                      elevation: 3,
                      shadowColor: Color.fromARGB(255, 209, 208, 208),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),

                ],
              ),
            ),


          )
        ],
      ),

    );
  }
}
