import 'package:flutter/material.dart';

class creditcard extends StatefulWidget {
  creditcard(
      {super.key,
      required this.company,
      required this.balance,
      required this.number});
  final String company;
  final double balance;
  final String number;
  @override
  State<creditcard> createState() => _creditcardState();
}

class _creditcardState extends State<creditcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 18, 201, 146),
              Color.fromARGB(255, 255, 220, 156)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    'images/${widget.company}.jpg',
                    width: 44,
                    height: 14,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Balance',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontFamily: 'Lexend', color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '₹ ${widget.balance}',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontFamily: 'Lexend', color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '**** ${widget.number}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'Roboto Mono', color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
