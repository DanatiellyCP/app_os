import 'package:flutter/material.dart';
import 'package:os804/models/produto.dart';
import 'package:os804/pages/preview_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final empresa = TextEditingController();
  final cliente = TextEditingController();
  final rodape = TextEditingController();

  List<Produto> produtos = [];

  void addProduto() {
    setState(() {
      produtos.add(Produto());
    });
  }

  void removerProduto(int index) {
    setState(() {
      produtos.removeAt(index);
    });
  }

  /// 🔥 NOVO: limpar tudo
  void limparFormulario() {
    setState(() {
      empresa.clear();
      cliente.clear();
      rodape.clear();
      produtos.clear();
    });
  }

  @override
  void dispose() {
    empresa.dispose();
    cliente.dispose();
    rodape.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ordem de Serviço"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Limpar formulário",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Limpar formulário"),
                  content: const Text("Deseja apagar todos os dados?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        limparFormulario();
                        Navigator.pop(context);
                      },
                      child: const Text("Limpar"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: empresa,
              decoration: const InputDecoration(labelText: "Empresa"),
            ),

            TextField(
              controller: cliente,
              decoration: const InputDecoration(labelText: "Cliente"),
            ),

            TextField(
              controller: rodape,
              decoration: const InputDecoration(labelText: "Rodapé"),
            ),

            const SizedBox(height: 10),

            ...produtos.asMap().entries.map((entry) {
              int i = entry.key;
              var p = entry.value;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Produto ${i + 1}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removerProduto(i),
                          )
                        ],
                      ),

                      TextField(
                        decoration: const InputDecoration(labelText: "Produto"),
                        onChanged: (v) => p.produto = v,
                      ),

                      TextField(
                        decoration: const InputDecoration(labelText: "Descrição"),
                        onChanged: (v) => p.descricao = v,
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Qtd"),
                        onChanged: (v) {
                          p.qtd = int.tryParse(v) ?? 0;
                          setState(() {});
                        },
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Valor Unitário"),
                        onChanged: (v) {
                          p.valorU = double.tryParse(v) ?? 0;
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total: R\$ ${p.total.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addProduto,
              child: const Text("Adicionar Produto"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PreviewPage(
                      empresa: empresa.text,
                      cliente: cliente.text,
                      rodape: rodape.text,
                      produtos: produtos,
                    ),
                  ),
                );
              },
              child: const Text("Gerar OS"),
            ),
          ],
        ),
      ),
    );
  }
}