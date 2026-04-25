import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/produto.dart';

Future<pw.Document> gerarPdf({
  required String empresa,
  required String cliente,
  required String rodape,
  required List<Produto> produtos,
}) async {
  final pdf = pw.Document();

  double totalGeral =
      produtos.fold(0, (sum, p) => sum + p.total);

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(24),
      build: (context) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
            borderRadius: pw.BorderRadius.circular(10),
          ),
          padding: const pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              /// TÍTULO
              pw.Center(
                child: pw.Text(
                  "OS | Encomendas",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 15),

              /// EMPRESA / CLIENTE
              pw.Text(
                "Empresa: ${empresa.isEmpty ? '-' : empresa}",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),

              pw.Text(
                "Cliente: ${cliente.isEmpty ? '-' : cliente}",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),

              pw.SizedBox(height: 20),

              /// PRODUTOS
              pw.Text(
                "Produtos",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),

              pw.SizedBox(height: 10),

              /// TABELA
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(1),
                  3: const pw.FlexColumnWidth(1),
                },
                children: [

                  /// CABEÇALHO
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      _cell("Produto", isHeader: true),
                      _cell("Qtd", isHeader: true),
                      _cell("Valor", isHeader: true),
                      _cell("Total", isHeader: true),
                    ],
                  ),

                  /// DADOS
                  ...produtos.map((p) {
                    return pw.TableRow(
                      children: [
                        _cell(p.produto.isEmpty ? '-' : p.produto),
                        _cell("${p.qtd}"),
                        _cell("R\$ ${p.valorU.toStringAsFixed(2)}"),
                        _cell("R\$ ${p.total.toStringAsFixed(2)}"),
                      ],
                    );
                  }),
                ],
              ),

              pw.SizedBox(height: 15),

              /// TOTAL
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  "Total Geral: R\$ ${totalGeral.toStringAsFixed(2)}",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 30),

              /// RODAPÉ
              pw.Center(
                child: pw.Text(
                  rodape.isEmpty ? '' : rodape,
                  style: const pw.TextStyle(color: PdfColors.grey),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf;
}

/// 🔧 Helper para células da tabela
pw.Widget _cell(String text, {bool isHeader = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(6),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontWeight:
            isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    ),
  );
}