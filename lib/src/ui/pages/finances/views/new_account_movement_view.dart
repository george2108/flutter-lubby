part of '../finances_main_page.dart';

class NewAccountMovementView extends StatefulWidget {
  final BuildContext blocContext;

  const NewAccountMovementView({super.key, required this.blocContext});

  @override
  State<NewAccountMovementView> createState() => _NewAccountMovementViewState();
}

class _NewAccountMovementViewState extends State<NewAccountMovementView> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  AccountEntity? accountSelected;

  final amountMask = MaskTextInputFormatter(
    mask: '####################',
    filter: {
      "#": RegExp(r'^-?[0-9]{0,10}(\.[0-9]{0,2})?$'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const _ChooseMovement(),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Descripción del movimiento',
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              inputFormatters: [amountMask],
              decoration: const InputDecoration(
                labelText: 'Monto',
                hintText: 'Monto del movimiento',
                icon: Text(
                  'MXN',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El monto es requerido';
                }

                final n = num.tryParse(value);
                if (n == null) {
                  return '"$value" no es un número válido';
                }

                return null;
              },
            ),
            const SizedBox(height: 15.0),
            SelectAccountInNewMovementWidget(
              accountSelected: accountSelected,
              blocContext: widget.blocContext,
            ),
            const SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                print('Tapped');
              },
              child: const TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.tag),
                  suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                  labelText: 'Agregar una categoría',
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.red,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.cast_connected,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Expanded(
                    child: Text(
                      'Para la moto',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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

class _ChooseMovement extends StatefulWidget {
  final Function(String value)? onValueChanged;

  const _ChooseMovement({
    Key? key,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<_ChooseMovement> createState() => _ChooseMovementState();
}

class _ChooseMovementState extends State<_ChooseMovement> {
  int optionSelected = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl(
      groupValue: optionSelected,
      unselectedColor: Theme.of(context).canvasColor,
      children: {
        0: Row(
          children: const [
            Icon(Icons.arrow_upward),
            Text('Déposito'),
          ],
        ),
        1: Row(
          children: const [
            Icon(Icons.arrow_downward),
            Text('Retiro'),
          ],
        ),
        2: Row(
          children: const [
            Icon(Icons.swap_horiz),
            Text('Transferencia'),
          ],
        ),
      },
      onValueChanged: (value) {
        setState(() {
          optionSelected = value;
        });
        widget.onValueChanged?.call(
          optionSelected == 0
              ? TypeTransactionsEnum.income.name
              : optionSelected == 1
                  ? TypeTransactionsEnum.expense.name
                  : TypeTransactionsEnum.transfer.name,
        );
      },
    );
  }
}
