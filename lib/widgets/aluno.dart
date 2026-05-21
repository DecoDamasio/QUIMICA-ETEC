class Aluno {
  final int id;
  final String nome;
  final int? nivel1;
  final int? nivel2;
  final int? nivel3;
  final int? nivel4;

  Aluno({
    required this.id,
    required this.nome,
    this.nivel1,
    this.nivel2,
    this.nivel3,
    this.nivel4,
  });

  // média formatada com 1 casa decimal
  double get media {
    List<int> notas = [nivel1, nivel2, nivel3, nivel4].whereType<int>().toList();
    if (notas.isEmpty) return 0.0;
    int soma = notas.reduce((a, b) => a + b);
    return double.parse((soma / notas.length).toStringAsFixed(1));
  }
}