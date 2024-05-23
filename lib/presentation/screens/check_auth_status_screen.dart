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
            padding: EdgeInsets.all(16.0), // Ajusta el padding según sea necesario
            child: Text(
              'from Evert H', // El texto que quieres mostrar al final
              style: TextStyle(
                fontSize: 18, // Ajusta el tamaño de la fuente según sea necesario
                color: Colors.black, // Ajusta el color según sea necesario
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
}
}