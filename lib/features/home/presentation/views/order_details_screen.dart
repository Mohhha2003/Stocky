import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project1/core/utils/assets.dart';
import 'package:project1/features/home/data/models/order/order.dart';
import 'package:project1/features/home/data/models/order/product.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xff964B00),
        height: 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'total price:',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  Text(
                    '${order.totalPrice} EGP',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  Text(
                    '${order.status}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff964B00),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        title: Text(order.id.toString()),
      ),
      body: ListView.builder(
        itemCount: order.products!.length,
        itemBuilder: (context, index) {
          Product product = order.products![index];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: CustomOrderDetailsItem(product: product),
          );
        },
      ),
    );
  }
}

class CustomOrderDetailsItem extends StatelessWidget {
  const CustomOrderDetailsItem({super.key, required this.product});
  final Product product;

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Qty:  ${product.quantity}'),
                    ),
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
