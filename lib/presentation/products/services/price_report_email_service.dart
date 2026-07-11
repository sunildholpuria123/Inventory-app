import '../../../data/database/app_database.dart';

class PriceReportEmailService {
  String buildHtml(List<ProductPriceHistory> items) {
    final buffer = StringBuffer();

    buffer.writeln('<h2>Price History Report</h2>');

    buffer.writeln('<table border="1">');

    buffer.writeln(
      '<tr>'
      '<th>Date</th>'
      '<th>Old</th>'
      '<th>New</th>'
      '<th>Inflation</th>'
      '</tr>',
    );

    for (final item in items) {
      buffer.writeln(
        '<tr>'
        '<td>${item.changedAt}</td>'
        '<td>${item.oldPurchasePrice}</td>'
        '<td>${item.newPurchasePrice}</td>'
        '<td>${item.inflationPercentage.toStringAsFixed(2)}%</td>'
        '</tr>',
      );
    }

    buffer.writeln('</table>');

    return buffer.toString();
  }
}
