import 'dart:io';
import 'package:flutter/material.dart';

class DeteksiPage extends StatefulWidget {
  final Map data;
  final File image;
  const DeteksiPage({Key? key, required this.image, required this.data}) : super(key: key);

  @override
  State<DeteksiPage> createState() => _DeteksiPageState();
}

class _DeteksiPageState extends State<DeteksiPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            );
          }),
        title: Text(
            "Hasil Deteksi",
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16.0,),
              Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width - 32.0,
                height: 361.0,
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
                    children: [
                      Image.file(
                        widget.image,
                        width: 216,
                        height: 241,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Inveksi : ${widget.data['predicted']}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                         "Identification Score : ${widget.data['score']}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                        ),
                      ),

                    ],
                  ),
                ),

              )
            ],
          ),
        ),

      ),
    );
  }
}
