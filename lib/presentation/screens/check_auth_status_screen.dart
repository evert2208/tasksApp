import 'package:flutter/material.dart';


class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
     return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Expanded(
            child: Container(),
          ),
          
          Center(
            child: Image.asset(
              'assets/images/T.png', 
              width: 150, 
              height: 150, 
            ),
          ),
          
          Expanded(
            child: Container(),
          ),
          
          const Padding(
            padding: EdgeInsets.all(16.0), 
            child: Text(
              'from Evert H',
              style: TextStyle(
                fontSize: 18, 
                color: Colors.black, 
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
}
}