import 'package:flutter/material.dart';

class ConectDevicePage extends StatelessWidget {
  const ConectDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paso 1: Conectar Dispositivo"),
      ),

      body: Center(
        child: Text('Conectar Dispositivo'),
      ),

    );
  }
}