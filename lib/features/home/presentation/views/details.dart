import 'package:flutter/material.dart';
import 'package:project1/Services/repos/cart_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class ItemsDetails extends StatelessWidget {
  final ProductModel product;

  const ItemsDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Image.network(
            product.image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.4,
            fit: BoxFit.fill,
          ),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              "Size :   38 40 42 44 ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () async {
                try {
                  await CartRepo().addToCart(product: product);
                  showSnackBar(
                      text: 'Added To Cart',
                      context: context,
                      backgroundColor: Colors.green);
                } on Exception catch (e) {
                  showSnackBar(text: 'Error Adding to Cart', context: context);
                }
              },
              child: const Text("Add To Cart"),
            ),
          )
        ],
      ),
    );
  }
}
