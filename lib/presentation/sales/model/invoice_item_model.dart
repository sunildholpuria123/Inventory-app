import '../../../data/database/app_database.dart';

class InvoiceItemModel {
  final Product product;

  /// For Granite/Marble variants
  final String? variantName;

  final int qty;

  /// Unit Price
  final double price;

  /// AREA products only
  final double? height;

  final double? width;

  final double? area;

  InvoiceItemModel({
    required this.product,
    required this.qty,
    required this.price,
    this.variantName,
    this.height,
    this.width,
    this.area,
  });

  bool get isAreaBased => area != null && area! > 0;

  double get total {
    if (isAreaBased) {
      return (height! * width!*qty) * price;
    }

    return qty * price;
  }

  String get productName {
    if (variantName != null && variantName!.isNotEmpty) {
      return '${product.name} '
          '($variantName)';
    }

    return product.name;
  }

  String get measurementText {
    if (!isAreaBased) {
      return '';
    }

    return '${height?.toStringAsFixed(2)} × '
        '${width?.toStringAsFixed(2)} = '
        '${area?.toStringAsFixed(2)} sqft';
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,

      'productName': product.name,

      'variantName': variantName,

      'qty': qty,

      'price': price,

      'height': height,

      'width': width,

      'area': area,

      'total': total,
    };
  }

  factory InvoiceItemModel.fromJson(
    Map<String, dynamic> json,
    Product product,
  ) {
    return InvoiceItemModel(
      product: product,

      variantName: json['variantName'] as String?,

      qty: json['qty'] as int,

      price: (json['price'] as num).toDouble(),

      height: (json['height'] as num?)?.toDouble(),

      width: (json['width'] as num?)?.toDouble(),

      area: (json['area'] as num?)?.toDouble(),
    );
  }
}
