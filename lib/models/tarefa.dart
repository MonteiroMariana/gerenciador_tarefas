class Tarefa {
  int? id;
  String titulo;
  String descricao;
  String cor;
  bool arquivada;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.cor,
    this.arquivada = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'cor': cor,
      'arquivada': arquivada ? 1 : 0,
    };
  }

  static Tarefa fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      cor: map['cor'],
      arquivada: map['arquivada'] == 1,
    );
  }
}