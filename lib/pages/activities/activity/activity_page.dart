import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tablero'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(color: Colors.red),
            child: const Text('Hola aqui va algo wey'),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: double.infinity,
                    width: size.width * 0.7,
                    color: Colors.white,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                index == 0
                                    ? 'Nuevo'
                                    : index == 1
                                        ? 'En proceso'
                                        : 'Hecho',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz_outlined),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 101,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: GestureDetector(
                                  onTap: () {
                                    print('objeto seleccionado');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$index item de la lista'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            onPressed: () {},
                            label: const Text('Agregar tarjeta'),
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
