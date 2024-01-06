
import 'package:control_porton/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
 


class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Estado del Servidor: ${socketService.serverStatus}"),

          ],
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: (){
           socketService.socket.emit('fromClient', { 'mensaje': 'Hola desde Flutter'});
        }
      ),
   );
  }
}