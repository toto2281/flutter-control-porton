import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController _ssidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _serverResponse = "";
  List<String> _networks = [];
  String _selectedNetwork = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HTTP POST Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _ssidController,
              decoration: InputDecoration(labelText: 'SSID'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para realizar la consulta POST
                sendPostRequest();
              },
              child: Text('Enviar POST'),
            ),
            SizedBox(height: 20),
            Text('Respuesta del servidor: $_serverResponse'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para realizar la consulta POST
                sendPostRequestScan();
              },
              child: Text('Escanear Redes'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _networks.contains(_selectedNetwork) ? _selectedNetwork : null,
               items: _networks.map((String network) {
                 return DropdownMenuItem<String>(
                   value: network,
                   child: Text(network),
                 );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedNetwork = value!;
                  });
                },
                hint: Text('Selecciona una red'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendPostRequest() async {
    // URL de destino para la consulta POST
    var url = Uri.parse('http://192.168.1.1/parametro'); // Reemplaza con la dirección IP de tu ESP8266

    // Datos que deseas enviar en la consulta POST
    var data = {
      'new_ssid_config': _ssidController.text,
      'new_pwd_config': _passwordController.text,
    };

    // Realiza la consulta POST
    var response = await http.post(
      url,
      body: data,
    );

    // Verifica si la solicitud fue exitosa
    if (response.statusCode == 200) {
      setState(() {
        _serverResponse = response.body;
      });
    } else {
      setState(() {
        _serverResponse = 'Error en la solicitud: ${response.statusCode}';
      });
    }
  }

  Future<void> sendPostRequestScan() async {
    // URL de destino para la consulta POST
    var url = Uri.parse('http://192.168.1.1/scanNetworks'); // Reemplaza con la dirección IP de tu ESP8266

    // Datos que deseas enviar en la consulta POST
    var data = {
      'new_ssid_config': _ssidController.text,
      'new_pwd_config': _passwordController.text,
    };

    // Realiza la consulta POST
    var response = await http.post(
      url,
      body: data,
    );

    // Verifica si la solicitud fue exitosa
    if (response.statusCode == 200) {
      setState(() {
        _serverResponse = response.body;
        _networks = buildNetworkList(response.body);
        _selectedNetwork = ""; // Limpiar la selección al escanear
      });
    } else {
      setState(() {
        _serverResponse = 'Error en la solicitud: ${response.statusCode}';
      });
    }
  }

  List<String> buildNetworkList(String responseBody) {
    var data = jsonDecode(responseBody);
    var networks = data['networks'];
    List<String> networkList = [];

    for (var network in networks) {
      networkList.add(network['SSID']);
    }

    return networkList;
  }
}
