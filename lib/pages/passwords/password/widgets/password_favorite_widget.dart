part of '../password_page.dart';

class PasswordFavoriteWidget extends StatelessWidget {
  const PasswordFavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.watch<PasswordBloc>().state.favorite
            ? Icons.star
            : Icons.star_border_outlined,
      ),
      onPressed: () {
        context.read<PasswordBloc>().add(PasswordMarkedFavorite());
      },
    );
  }
}
