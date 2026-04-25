class Produto {
  String produto;
  String descricao;
  int qtd;
  double valorU;

  Produto({
    this.produto = '',
    this.descricao = '',
    this.qtd = 0,
    this.valorU = 0,
  });

  double get total => qtd * valorU;
}