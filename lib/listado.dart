import 'package:ep02ejercicio02tokumotomora/db.dart';
import 'package:ep02ejercicio02tokumotomora/artefacto.dart';
import 'package:flutter/material.dart';

class Listado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Artefactos Electrónicos",
          style: TextStyle(color: Colors.white), // Texto blanco
        ),
        backgroundColor: Colors.blue, // Color de fondo azul
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/editar",
            arguments: Artefacto(id: 0, descripcion: "", modelo: "", precio: ""),
          );
        },
        backgroundColor: Colors.blue, // Color de fondo azul
      ),
      body: Container(
        child: Lista(),
      ),
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Artefacto> artefacto = [];

  @override
  void initState() {
    cargarArtefactos();
    super.initState();
  }

  cargarArtefactos() async {
    List<Artefacto> auxArtefacto = await DB.artefacto();
    setState(() {
      artefacto = auxArtefacto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artefacto.length,
      itemBuilder: (context, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        onDismissed: (direction) {
          DB.delete(artefacto[i]);
        },
        child: ListTile(
          title: Text(
            artefacto[i].descripcion,
            style: TextStyle(color: Colors.black), // Texto negro
          ),
          trailing: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, "/editar", arguments: artefacto[i]);
            },
            child: Icon(Icons.edit),
            color: Colors.grey[400], // Fondo gris claro
          ),
        ),
      ),
    );
  }
}
