import 'package:entrance_test/src/constants/icon.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/constants/words.dart';
import 'package:entrance_test/src/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductReviewItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int rating;
  final String review;
  final String createdAt;

  const ProductReviewItem(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.rating,
      required this.review,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ic_star,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            ic_star,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            ic_star,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            ic_star,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            ic_star,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 4),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Text(
                DateUtil.getTimeAgo(
                    DateUtil.getDateFromShortServerFormat(createdAt)),
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
