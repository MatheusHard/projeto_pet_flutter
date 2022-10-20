import 'package:flutter/material.dart';

class Exemplo extends StatelessWidget {
  Exemplo(    {Key? key,
                this.title,
                required this.onPress
              }): super(key: key);
  var title;
  VoidCallback onPress; // Good

  @override
  Widget build(BuildContext context) {

    title ??= '''Sem Texto''';

    return Expanded(child: Container(
      height: 400,
      width: 400,
      color: Colors.amber,
      //tamanho externo:
      margin: const EdgeInsets.all(8.0),
      //tamalho interno:
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title),
          ElevatedButton(
          onPressed: onPress, child: const Text("SAlvar"),
          )
        ],
      ),
    )
    );
  }
}
