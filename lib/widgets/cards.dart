import 'package:flutter/material.dart';

const kDefault = 15.0;

Padding botCard(int index, String message) => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefault,
        vertical: kDefault,
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Google_Icon.png'),
              radius: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                  right: kDefault / 2, left: kDefault * 3.6),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefault / 1.1,
                vertical: kDefault / 1.2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(kDefault * 1.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: const Offset(kDefault / 1.2, kDefault / 2),
                    blurRadius: kDefault * 2,
                  ),
                ],
              ),
              child: Text(message),
            ),
          ),
        ],
      ),
    );

Padding userCard(int index, String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: kDefault,
      vertical: kDefault,
    ),
    child: Stack(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(
                left: kDefault / 2, right: kDefault * 3.6),
            padding: const EdgeInsets.symmetric(
              horizontal: kDefault / 1.1,
              vertical: kDefault / 1.2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(kDefault * 1.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.12),
                  offset: const Offset(.5, kDefault / 1.6),
                  blurRadius: kDefault * 2,
                ),
              ],
            ),
            child: Text(message),
          ),
        ),
      ],
    ),
  );
}
