part of '../password_page.dart';

class PasswordFavoriteWidget extends StatelessWidget {
  const PasswordFavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: context.watch<PasswordBloc>().state.favorite
          ? const Icon(
              Icons.star,
              color: Colors.yellow,
            )
          : const Icon(
              Icons.star_border_outlined,
            ),
      onPressed: () {
        context.read<PasswordBloc>().add(PasswordMarkedFavorite());
      },
    );
  }
}
