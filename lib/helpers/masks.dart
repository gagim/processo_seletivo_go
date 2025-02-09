import 'package:intl/intl.dart';
import 'package:string_mask/string_mask.dart';

class Masks {
  String maskLocate(double km, String neighborhood) {
    var formatter = StringMask('0,00');
    return '${formatter.apply(km.toString())}km - $neighborhood';
  }

  String maskMonetary(double valor) {
    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    return formatter.format(valor);
  }
}
