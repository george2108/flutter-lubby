part of '../finances_main_page.dart';

class AccountsPageItem extends StatelessWidget {
  const AccountsPageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 30.0,
      ),
      children: const [
        AccountInListWidget(),
        SizedBox(height: 10),
        AccountInListWidget(),
        SizedBox(height: 10),
        AccountInListWidget(),
      ],
    );
  }
}
