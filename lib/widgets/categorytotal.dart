import 'package:flutter/material.dart';

class categorytotal extends StatefulWidget {
  categorytotal({super.key, required this.title, required this.total});

  final String title;
  final int total;

  @override
  State<categorytotal> createState() {
    return _categorytotalstate();
  }
}

class _categorytotalstate extends State<categorytotal> {
  // Create a method to build the content widgets with the given context
  Widget buildContentCard(
      BuildContext context, Color backgroundColor, Color textColor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.34,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    '₹${widget.total}',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: textColor,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.title == 'Income' || widget.title == 'Credit'
        ? Theme.of(context).colorScheme.background
        : /* Define your red color here */ Theme.of(context)
            .colorScheme
            .background;

    Color textColor = widget.title == 'Income' || widget.title == 'Credit'
        ? Theme.of(context).colorScheme.primary
        : /* Define your text color here */ Theme.of(context)
            .colorScheme
            .error
            .withOpacity(1);

    return buildContentCard(context, backgroundColor, textColor);
  }
}
