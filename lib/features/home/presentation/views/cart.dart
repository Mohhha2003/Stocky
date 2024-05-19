import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/cart_repo.dart';
import 'package:project1/core/utils/assets.dart';
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomCartListItem(
                  product: products[index],
                ),
              ),
            ),
            itemCount: products.length,
          );
        }
      },
    );
  }
}

class CustomCartListItem extends StatelessWidget {
  final CartModel product;
  const CustomCartListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage(
                    Assets.imagesSweatshirt,
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          const Gap(15),
          Container(
            width: (MediaQuery.sizeOf(context).width / 2) - 10,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'sweatshirt',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 19),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text(
                    'nice sweatshirt with a good quality ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      45.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.orange),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async{
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${product.quantity}'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
