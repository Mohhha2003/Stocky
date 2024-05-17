import 'package:flutter/material.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/cart_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/cart/cart_model.dart';
import 'package:project1/features/home/data/models/product_model.dart';

import 'widgets/custom_product_list_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          CartRepo().getUserCartProduct(ownerId: AuthApi.currentUser.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error '),
          );
        } else {
          List<CartModel> products = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.transparent,
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  try {
                    await CartRepo().deleteFavourite(product: products[index]);
                    showSnackBar(text: 'Removed From Cart', context: context);
                  } catch (e) {
                    showSnackBar(
                        text: '`Failed to remove From Cart', context: context);
                  }
                }
              },
              key: GlobalKey(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomProductListItem(),
              ),
            ),
            itemCount: products.length,
          );
        }
      },
    );
  }
}
