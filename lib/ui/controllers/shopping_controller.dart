import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/product.dart';

class ShoppingController extends GetxController {
  // lista de productos
  var entries = <Product>[].obs;
  // el valor total de la compra
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // los dos elementos que vamos a tener en la tienda
    entries.add(Product(0, "Camisa", 10,
        "https://http2.mlstatic.com/D_NQ_NP_719433-MCO48814181161_012022-W.jpg"));
    entries.add(Product(1, "Pantalon", 20,
        "https://www.instyle.es/medio/2019/02/04/pantalones-vaqueros-cropped-primavera-uterque_b2a5edab_1000x1499.jpg"));
  }

  void calcularTotal() {
    int newTotal = 0;

    // calcular el valor total de los elementos en el carro de compras
    for (var itemProduct in entries) {
      newTotal = newTotal + (itemProduct.price * itemProduct.quantity);
    }
    total.value = newTotal;

    //logInfo('Total $newTotal');
  }

  void inicializarCantidades() {
    for (var itemProduct in entries) {
      itemProduct.quantity = 0;
    }
    calcularTotal();
    entries.refresh();
  }

  agregarProducto(id) {
    //logInfo('agregarProducto $id');

    // Encontrar el elemento usando el id, revisar el método firstWhere de la lista
    // después obtener el index de ese elemento, revisar el método indexOf de la lista
    // después hacer el incremento en la cantidad
    // finalmente actualizar entries usando el indice y el elemento actualizado
    var result = entries.firstWhere((element) => element.id == id);
    final index = entries.indexOf(result);
    entries[index].quantity++;

    //logInfo(entries[index].quantity);
    calcularTotal();
  }

  quitarProducto(id) {
    //logInfo('quitarProducto $id');

    // similar a agregarProducto
    // validar cuando la cantidad es igual a cero

    var result = entries.firstWhere((element) => element.id == id);
    final index = entries.indexOf(result);

    if (entries[index].quantity > 0) {
      entries[index].quantity--;
    }

    //logInfo(entries[index].quantity);
    calcularTotal();
  }
}
