import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/features/home/data/models/product_model.dart';
import '../../../../Services/api_con.dart';
import 'details.dart';
import 'fliter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiCon apiCon = ApiCon();
  @override
  void initState() {
    Fav().getUserFavourites(ownerId: '66436148997939ee89ee912f');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            const FliterPart(
              categories: ["Bags", "T-Shirts", "Shoes", "SweatShirt", "Other"],
            ),
            const SizedBox(height: 30),
            Container(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Gender",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const FliterPart(
              categories: ['Male', 'Female'],
            ),
            Container(height: 20),
            FutureBuilder<List<ProductModel>>(
              future: apiCon.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ProductModel>? products = snapshot.data;
                  return GridView.builder(
                    itemCount: products?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 359,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel product = products![index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemsDetails(product: product),
                            ),
                          );
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(product
                                          .image), // Use product's image URL
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.description,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                CustomPriceRow(
                                  product: product,
                                  price: product.price,
                                  productId: product.id,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPriceRow extends StatelessWidget {
  final int price;

  const CustomPriceRow({
    Key? key,
    required this.price,
    required this.productId,
    required this.product,
  }) : super(key: key);

  final String productId;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          price.toString(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            print('FAvvvv');
            Fav().addToFavorite(product: product);
          },
          icon: const Icon(IconlyBroken.heart),
        ),
      ],
    );
  }
}
