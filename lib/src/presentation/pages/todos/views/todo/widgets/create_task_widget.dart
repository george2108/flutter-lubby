part of '../todo_page.dart';

class CreateTaskWidget extends StatelessWidget {
  const CreateTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.close),
                    label: Container(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Nueva tarea'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      label: Text('Titulo'),
                      hintText: 'Título de la tarea',
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text('Descripción'),
                      hintText: 'Descripción de la tarea',
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    title: Text('Fecha'),
                    trailing: Text('esta es la fecha'),
                    onTap: () async {
                      final fecha = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050, 12, 31),
                        locale: const Locale("es", "ES"),
                      );
                      print(fecha);
                    },
                  ),
                  ListTile(
                    title: Text('Hora'),
                    trailing: Text('Seleccionar la hora'),
                    onTap: () async {
                      final hora = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      print(hora);
                    },
                  ),
                  Wrap(
                    children: [
                      Chip(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.add_circle_outline_sharp),
                            Text('Agregar etiquetas'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
