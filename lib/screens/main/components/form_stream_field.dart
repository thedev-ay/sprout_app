import 'package:flutter/material.dart';

class FormStreamField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSensitive;
  final Function dispatch;
  final Stream subscribe;

  const FormStreamField({
    Key key,
    this.label,
    this.icon,
    this.isSensitive = false,
    this.dispatch,
    this.subscribe,
  }) : super(key: key);

  @override
  _FormStreamFieldState createState() => _FormStreamFieldState();
}

class _FormStreamFieldState extends State<FormStreamField> {
  TextEditingController controller = new TextEditingController();
  bool isTextVisible = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.subscribe,
        builder: (context, snapshot) {
          controller.value = controller.value.copyWith(text: snapshot.data);
          return TextField(
            autofocus: false,
            controller: controller,
            obscureText: widget.isSensitive ? !isTextVisible : false,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            decoration: InputDecoration(
              suffixIcon: setSuffixIcon(context),
              prefixIcon: Icon(widget.icon),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.label,
              contentPadding: const EdgeInsets.all(15),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onChanged: widget.dispatch,
          );
        });
  }

  GestureDetector setSuffixIcon(BuildContext context) {
    return widget.isSensitive
        ? GestureDetector(
            child: Icon(
              isTextVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onLongPress: () {
              setState(() {
                isTextVisible = true;
              });
            },
            onLongPressUp: () {
              setState(() {
                isTextVisible = false;
              });
            },
          )
        : null;
  }
}
