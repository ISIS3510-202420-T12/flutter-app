import 'package:flutter/material.dart';

class VendorProfileCard extends StatefulWidget {
  const VendorProfileCard({super.key});

  @override
  State<VendorProfileCard> createState() => _VendorProfileCardState();
}

class _VendorProfileCardState extends State<VendorProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: 1)
          ]),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle_sharp,
                  size: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vendor's name"),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(
                          width: 10,
                        ),
                        Text("(47)")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_clock,
                  size: 40,
                ),
                Column(
                  children: [
                    Text(
                      "Delivery Time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("4.8 minutes")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
