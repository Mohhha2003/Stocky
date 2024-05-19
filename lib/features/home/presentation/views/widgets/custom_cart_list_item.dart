import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project1/core/utils/assets.dart';
import 'package:project1/features/home/data/models/cart/cart_model.dart';

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
                      onPressed: () async {},
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
