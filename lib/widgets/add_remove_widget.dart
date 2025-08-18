import 'package:flutter/material.dart';

class AddRemoveWidget extends StatelessWidget {
  final Function()? onPressedAdd;
  final Function()? onPressedRemove;
  final String title;

  const AddRemoveWidget(
      {super.key,
      this.onPressedAdd,
      this.onPressedRemove,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getButton(context, onPressedRemove, const Icon(Icons.remove)),
          Text(title),
          _getButton(context, onPressedAdd, const Icon(Icons.add))
        ],
      ),
    );
  }

  Widget _getButton(BuildContext context, Function()? fun, Icon icon) {
    return IconButton(
        icon: icon,
        color: Colors.white,
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor)),
        onPressed: fun);
  }
}
