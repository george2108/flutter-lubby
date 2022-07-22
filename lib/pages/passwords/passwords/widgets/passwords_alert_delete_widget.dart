part of '../passwords_page.dart';

class PasswordsAlertDeleteWidget extends StatelessWidget {
  final int id;
  final BuildContext blocContext;

  const PasswordsAlertDeleteWidget({
    required this.id,
    required this.blocContext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text('¿Estas seguro de eliminar esta constraseña?'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<PasswordsBloc>(blocContext)
                        .add(PasswordsDeletedEvent(id));
                    Navigator.of(context).pop();
                    Navigator.of(blocContext).pop();
                  },
                  child: const Text('Si, eliminar'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
