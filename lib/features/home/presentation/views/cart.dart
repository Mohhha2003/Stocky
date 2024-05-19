import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/cart_repo.dart';
import 'package:project1/Services/repos/orders_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/home/data/models/cart/cart_model.dart';
import 'package:project1/features/home/presentation/views/widgets/custom_cart_list_item.dart';
import 'package:project1/features/home/presentation/views/widgets/empty_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartRepo cartRepo;
  late OrdresRepo ordresRepo;

  @override
  void initState() {
    cartRepo = CartRepo();
    ordresRepo = OrdresRepo();
    super.initState();
  }

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
          if (products.isEmpty) {
            return const EmptyWidget(
              svgImagePath: 'assets/images/fav.svg',
              text: 'No Favourites was found ',
            );
          }
          return AuthApi.currentUser.id == null
              ? const Center(
                  child: Text('Please Login To Add To Cart'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
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
                                await cartRepo.deleteFromCart(
                                    product: products[index]);
                                showSnackBar(
                                    text: 'Removed From Cart',
                                    context: context);
                              } catch (e) {
                                showSnackBar(
                                    text: '`Failed to remove From Cart',
                                    context: context);
                              }
                            }
                            setState(() {});
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
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(15),
                      onPressed: () async {
                        try {
                          await ordresRepo.placeOrder(products: products);
                          showSnackBar(
                              text: 'Order Places Succesfuly',
                              context: context,
                              backgroundColor: Colors.green);
                          await cartRepo.clearUserCart();
                        } on Exception catch (e) {
                          showSnackBar(
                              text: 'Error Placing Order', context: context);
                        }
                        setState(() {});
                      },
                      color: const Color(0xff964B00),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Gap(100)
                  ],
                );
        }
      },
    );
  }
}
