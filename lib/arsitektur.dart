import 'package:flutter/material.dart';

class ArsitekturPage extends StatelessWidget {
  const ArsitekturPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      "Arsitektur Model Deep Learning",
                      style: TextStyle(
                        fontSize: 21.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 15,),
                    Image.asset(
                      'assets/images/arsitektur.png',
                      width: MediaQuery.of(context).size.width - 64.0,
                      height: 281,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "Arsitektur memiliki 20 layer, dengan 12 convolution layer, 5 pooling layer, satu LSTM layer, satu FC layer, dan satu output layer dengan fungsi aktivasi softmax.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  fontFamily: 'Poppins',

                ),
              )

            ],
          ),
        )
    );
  }

}
