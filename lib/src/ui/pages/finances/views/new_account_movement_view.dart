part of '../finances_main_page.dart';

class NewAccountMovementView extends StatefulWidget {
  final BuildContext blocContext;

  const NewAccountMovementView({super.key, required this.blocContext});

  @override
  State<NewAccountMovementView> createState() => _NewAccountMovementViewState();
}

class _NewAccountMovementViewState extends State<NewAccountMovementView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  AccountEntity? accountSelected;
  AccountEntity? accountDestSelected;
  LabelEntity? categorySelected;
  String type = TypeTransactionsEnum.income.name;

  final amountMask = MaskTextInputFormatter(
    mask: '####################',
    filter: {
      "#": RegExp(r'^-?[0-9]{0,10}(\.[0-9]{0,2})?$'),
    },
  );

  createTransaction() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (accountSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Selecciona una cuenta',
          description: 'Selecciona una cuenta para el movimiento',
          type: TypeSnackbar.warning,
        ),
      );
      return;
    }

    if (type == TypeTransactionsEnum.transfer.name &&
        accountDestSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Selecciona una cuenta de destino',
          description: 'Selecciona una cuenta de destino para el movimiento',
          type: TypeSnackbar.warning,
        ),
      );
      return;
    }

    if (type == TypeTransactionsEnum.transfer.name &&
        accountSelected!.id == accountDestSelected!.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Selecciona una cuenta de destino diferente',
          description:
              'Selecciona una cuenta de destino diferente para el movimiento',
          type: TypeSnackbar.warning,
        ),
      );
      return;
    }

    if (type != TypeTransactionsEnum.transfer.name &&
        categorySelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Selecciona una categoría',
          description: 'Selecciona una categoría para el movimiento',
          type: TypeSnackbar.warning,
        ),
      );
      return;
    }

    if ((type == TypeTransactionsEnum.transfer.name ||
            type == TypeTransactionsEnum.expense.name) &&
        accountSelected!.balance < double.parse(_montoController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarWidget(
          title: 'Saldo insuficiente',
          description:
              'No tienes saldo suficiente para realizar esta transferencia',
          type: TypeSnackbar.warning,
        ),
      );
      return;
    }

    final newTransaction = TransactionEntity(
      title: _descripcionController.text,
      amount: double.parse(_montoController.text),
      description: _descripcionController.text,
      type: type,
      createdAt: DateTime.now(),
      accountId: accountSelected!.id!,
      account: accountSelected!,
      accountDestId: accountDestSelected?.id,
      accountDest: accountDestSelected,
      label: categorySelected,
      labelId: categorySelected?.id,
    );

    BlocProvider.of<FinancesBloc>(widget.blocContext)
        .add(CreateTransactionEvent(newTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
        actions: [
          TextButton.icon(
            onPressed: createTransaction,
            icon: const Icon(Icons.check),
            label: const Text('Guardar'),
          ),
        ],
      ),
      body: BlocListener<FinancesBloc, FinancesState>(
        bloc: BlocProvider.of<FinancesBloc>(widget.blocContext),
        listener: (_, state) {},
        listenWhen: (previous, current) {
          if (current.transactions.length > previous.transactions.length) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBarWidget(
                title: 'Movimiento creado',
                description: 'El movimiento se ha creado correctamente',
              ),
            );
            Navigator.of(context).pop();
          }
          return false;
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ChooseMovementTypeWidget(
            onValueChanged: (value) {
              setState(() {
                type = value;
                categorySelected = null;
                accountDestSelected = null;
              });
            },
          ),
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
            onAccountSelected: (account) {
              accountSelected = account;
            },
            type: type == TypeTransactionsEnum.transfer.name
                ? TypeTransactionsEnum.transfer
                : type == TypeTransactionsEnum.income.name
                    ? TypeTransactionsEnum.income
                    : TypeTransactionsEnum.expense,
          ),
          const SizedBox(height: 15.0),
          if (type == TypeTransactionsEnum.transfer.name)
            SelectAccountInNewMovementWidget(
              accountSelected: accountDestSelected,
              blocContext: widget.blocContext,
              onAccountSelected: (account) {
                accountDestSelected = account;
              },
              isDest: true,
              type: type == TypeTransactionsEnum.transfer.name
                  ? TypeTransactionsEnum.transfer
                  : type == TypeTransactionsEnum.income.name
                      ? TypeTransactionsEnum.income
                      : TypeTransactionsEnum.expense,
            ),
          if (type != TypeTransactionsEnum.transfer.name)
            SelectCategoryMovementWidget(
              blocContext: widget.blocContext,
              categorySelected: categorySelected,
              type: type,
              onCategorySelected: (category) {
                categorySelected = category;
              },
            ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
