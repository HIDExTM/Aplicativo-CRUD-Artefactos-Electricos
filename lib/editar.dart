import 'package:ep02ejercicio02tokumotomora/db.dart';
import 'package:ep02ejercicio02tokumotomora/artefacto.dart';
import 'package:flutter/material.dart';

class Editar extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final descripcionController = TextEditingController();
  final modeloController = TextEditingController();
  final precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final producto = ModalRoute.of(context)!.settings.arguments as Artefacto;
    descripcionController.text = producto.descripcion;
    modeloController.text = producto.modelo;
    precioController.text = producto.precio;

    return Scaffold(
      appBar: AppBar(title: Text("Guardar")),
      body: Container(
        child: Padding(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: descripcionController,
                  validator: (value){
                    if(value.toString().isEmpty)
                      return "La descripcion es obligatoria";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Descripción",
                    filled: true,
                    fillColor: Colors.blue.shade50, // Fondo azul claro
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: modeloController,
                  validator:(value){
                    if (value.toString().isEmpty)
                      return "El modelo es obligatorio";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Modelo",
                    filled: true,
                    fillColor: Colors.blue.shade50, // Fondo azul claro
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: precioController,
                  validator:(value){
                    if (value.toString().isEmpty)
                      return "El precio es obligatorio";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Precio",
                    filled: true,
                    fillColor: Colors.blue.shade50, // Fondo azul claro
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                      if(producto.id > 0){
                        producto.descripcion = descripcionController.text;
                        producto.modelo = modeloController.text;
                        producto.precio = precioController.text;
                        DB.update(producto);
                      } else {
                        DB.insert(Artefacto(
                          id:producto.id,
                          descripcion: descripcionController.text,
                          modelo: modeloController.text,
                          precio: precioController.text));
                      }
                      Navigator.pushNamed(context,"/");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Fondo azul
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Texto blanco
                  ),
                  child: Text("Guardar"),
                )
              ]
            ),
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
