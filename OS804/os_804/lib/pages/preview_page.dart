import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../models/produto.dart';
import '../services/pdf_service.dart';

class PreviewPage extends StatelessWidget {
  final String empresa;
  final String cliente;
  final String rodape;
  final List<Produto> produtos;

  const PreviewPage({
    super.key,
    required this.empresa,
    required this.cliente,
    required this.rodape,
    required this.produtos,
  });

  double get totalGeral =>
      produtos.fold(0, (sum, p) => sum + p.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview OS"),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: "Gerar PDF",
            onPressed: () async {
              final pdf = await gerarPdf(
                empresa: empresa,
                cliente: cliente,
                rodape: rodape,
                produtos: produtos,
              );

              await Printing.layoutPdf(
                onLayout: (format) async => pdf.save(),
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TÍTULO
              const Center(
                child: Text(
                  "OS | Encomendas",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// EMPRESA / CLIENTE
              Text(
                "Empresa: ${empresa.isEmpty ? '-' : empresa}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              Text(
                "Cliente: ${cliente.isEmpty ? '-' : cliente}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20),

              /// TÍTULO PRODUTOS
              const Text(
                "Produtos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              /// TABELA
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [

                  /// CABEÇALHO
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.black12),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Produto"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Qtd"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Valor"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Total"),
                      ),
                    ],
                  ),

                  /// LINHAS
                  ...produtos.map((p) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            p.produto.isEmpty ? '-' : p.produto,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("${p.qtd}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("R\$ ${p.valorU.toStringAsFixed(2)}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("R\$ ${p.total.toStringAsFixed(2)}"),
                        ),
                      ],
                    );
                  }),
                ],
              ),

              const SizedBox(height: 15),

              /// TOTAL
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Total Geral: R\$ ${totalGeral.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// RODAPÉ
              Center(
                child: Text(
                  rodape.isEmpty ? '' : rodape,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}