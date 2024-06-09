import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {

  final String name, imageUrl, price, offerTag;
  final Function onItemTab;

  const ProductItem(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.offerTag, required this.onItemTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onItemTab();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top image
              Image.network(
                // 'https://m.media-amazon.com/images/I/71+86XeG0kL._AC_SL1500_.jpg',
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              const SizedBox(
                height: 6,
              ),

              //Name textView
              Text(
                style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                name,
              ),
              const SizedBox(
                height: 0,
              ),

              //price textView
              Text(
                style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400),
                "Tk: $price",
              ),

              const SizedBox(
                height: 4,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  offerTag,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
