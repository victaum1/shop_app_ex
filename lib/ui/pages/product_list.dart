import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/product.dart';
import '../widgets/banner.dart';
import '../controllers/shopping_controller.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ShoppingController shoppingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [const CustomBanner(50), customAppBar()],
            ),
            //
            // aquí debemos rodear el widget Expanded en un Obx para
            // observar los cambios en la lista de entries del shoppingController
            Obx(() => Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: shoppingController.entries.length,
                      itemBuilder: (context, index) {
                        return _row(shoppingController.entries[index], index);
                      }),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              // ignore: prefer_const_constructors
              BottomNavigationBarItem(
                  icon: const Icon(Icons.arrow_back), label: 'Regresar'),
              // ignore: prefer_const_constructors
              BottomNavigationBarItem(
                  icon: const Icon(Icons.cleaning_services_outlined),
                  label: 'Inicializar'),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.payment),
                  label: '\$${shoppingController.total}'),
            ],
            onTap: (value) {
              if (value == 0) {
                Get.back();
              } else if (value == 1) {
                shoppingController.inicializarCantidades();
              }
            },
          )),
    );
  }

  Widget customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _row(Product product, int index) {
    return _card(product);
  }

  Widget _card(Product product) {
    return Card(
      color: Colors.blue[50],
      margin: const EdgeInsets.all(4.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image(
          image: NetworkImage(product.urlImgen),
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
        Text(product.name),
        Text('\$${product.price}'),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  //
                  // aquí debemos llamar al método del controlador que
                  // incrementa el número de unidades del producto
                  // pasandole el product.id
                  shoppingController.agregarProducto(product.id);
                  shoppingController.entries.refresh();
                },
                icon: const Icon(Icons.add_circle)),
            IconButton(
                onPressed: () {
                  //
                  // aquí debemos llamar al método del controlador que
                  // disminuye el número de unidades del producto
                  // pasandole el product.id
                  shoppingController.quitarProducto(product.id);
                  shoppingController.entries.refresh();
                },
                icon: const Icon(Icons.remove_circle))
          ],
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Quantity"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.quantity.toString()),
            ),
          ],
        )
      ]),
    );
  }
}
