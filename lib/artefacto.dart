class Artefacto{
  int id;
  String descripcion;
  String modelo;
  String precio;

  Artefacto(
      {required this.id,
      required this.descripcion,
      required this.modelo,
      required this.precio});

  Map<String, dynamic> tomap() {
    return {'id': id, 'descripcion': descripcion, 'modelo': modelo, 'precio': precio};
  }

  Map<String, dynamic> tomapI() {
    return {'descripcion': descripcion, 'modelo': modelo, 'precio': precio};
  }
}
