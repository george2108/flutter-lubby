import 'package:flutter/material.dart';

enum ListaDeCategorias {
  deportes,
  tecnologia,
  hogar,
  comidas,
  salud,
  animales,
  transporte,
  viajes,
  moda,
}

Map<String, String> categorias = {
  ListaDeCategorias.deportes.name: 'Deportes',
  ListaDeCategorias.tecnologia.name: 'Tecnología',
  ListaDeCategorias.hogar.name: 'Hogar',
  ListaDeCategorias.comidas.name: 'Comidas',
  ListaDeCategorias.salud.name: 'Salud',
  ListaDeCategorias.animales.name: 'Animales',
  ListaDeCategorias.transporte.name: 'Transporte',
  ListaDeCategorias.viajes.name: 'Viajes',
  ListaDeCategorias.moda.name: 'Moda',
};

class CategoryIcons {
  String category;
  IconData icon;

  CategoryIcons({
    required this.category,
    required this.icon,
  });
}

List<CategoryIcons> listCategoriesIcons = [
  //////////////////////////////////////////////////////////////////////////////
  // tecnologia
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.computer,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.desktop_windows,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.device_hub,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.devices_other,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.dock,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.gamepad,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.headset,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.keyboard,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.keyboard_arrow_down,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.keyboard_arrow_left,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.laptop,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.laptop_chromebook,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.laptop_mac,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.laptop_windows,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.memory,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.mouse,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.phone_android,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.phone_iphone,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.phonelink,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.phonelink_off,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.power_input,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.router,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.scanner,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.security,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.sim_card,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.smartphone,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.speaker,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.speaker_group,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.tablet,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.tecnologia.name]!,
    icon: Icons.tablet_android,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// deportes
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.directions_run,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.fitness_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.golf_course,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.pool,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.rowing,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.spa,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_baseball,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_basketball,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_cricket,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_esports,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_football,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_golf,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_handball,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_hockey,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_kabaddi,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_mma,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_motorsports,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_rugby,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_soccer,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_tennis,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.sports_volleyball,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.tag_faces,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.terrain,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.weekend,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.work_outline,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.attach_money,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.business_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.casino,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.child_friendly,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.deportes.name]!,
    icon: Icons.local_activity,
  ),

  //////////////////////////////////////////////////////////////////////////////
  // HOgar
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.home,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.house,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.hotel,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.invert_colors,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.kitchen,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_laundry_service,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_hotel,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_mall,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_offer,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_parking,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_pharmacy,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_pizza,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_play,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_post_office,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_printshop,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.local_shipping,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.location_city,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.location_disabled,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.location_off,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.location_on,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.location_searching,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.map,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.my_location,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.navigation,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.near_me,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.person_pin,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.person_pin_circle,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.hogar.name]!,
    icon: Icons.room_service,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// comidas
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.fastfood,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.free_breakfast,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_bar,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_cafe,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_dining,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_drink,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_florist,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_gas_station,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_grocery_store,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_library,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_movies,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_offer,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_pizza,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_play,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.local_shipping,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.restaurant,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.restaurant_menu,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.room_service,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.smoke_free,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.smoking_rooms,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.spa,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.store_mall_directory,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.terrain,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.weekend,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.attach_money,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.business_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.casino,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.comidas.name]!,
    icon: Icons.child_friendly,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// salud
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.local_hospital,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.accessible,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.add_circle,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.add_circle_outline,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.alarm,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.alarm_add,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.alarm_off,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.alarm_on,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.all_inclusive,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.apartment,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment_ind,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment_late,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment_return,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment_returned,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.assignment_turned_in,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.autorenew,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.backup,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.book,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.bookmark,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.bookmark_border,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.build,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.cached,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.calendar_today,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.calendar_view_day,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.camera_enhance,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.card_giftcard,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.card_membership,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.card_travel,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.change_history,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.salud.name]!,
    icon: Icons.check_circle,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// animales
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.pets,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.catching_pokemon,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.whatshot,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.favorite,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.favorite_border,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.sentiment_very_satisfied,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.sentiment_satisfied,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.sentiment_neutral,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.sentiment_dissatisfied,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.sentiment_very_dissatisfied,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.thumb_up,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.thumb_down,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.thumbs_up_down,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.mood,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.mood_bad,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.notifications,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.notifications_active,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.notifications_none,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.notifications_off,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.notifications_paused,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.pages,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.party_mode,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.people,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.people_outline,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.person,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.person_add,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.person_outline,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.plus_one,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.poll,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.public,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.animales.name]!,
    icon: Icons.school,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// transporte
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.airport_shuttle,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_taxi,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.beach_access,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.business_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.casino,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.child_friendly,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_bike,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_boat,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_bus,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_car,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_railway,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_run,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_subway,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_transit,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.directions_walk,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.ev_station,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.flight,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.hot_tub,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_activity,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_airport,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_atm,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_attraction,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_car_wash,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_convenience_store,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_dining,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_drink,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_florist,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_gas_station,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.transporte.name]!,
    icon: Icons.local_hotel,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// viajes
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.airport_shuttle,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.beach_access,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.business_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.casino,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.child_friendly,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_bike,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_boat,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_bus,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_car,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_railway,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_run,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_subway,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_transit,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.directions_walk,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.ev_station,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.flight,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.hotel,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.hotel_class,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_activity,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_airport,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_atm,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_attraction,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_cafe,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_car_wash,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_convenience_store,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_dining,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_drink,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.viajes.name]!,
    icon: Icons.local_florist,
  ),
  //////////////////////////////////////////////////////////////////////////////
  /// moda
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.accessibility_new,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.accessibility,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.add_shopping_cart,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.attach_money,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.business_center,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.casino,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.child_friendly,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.color_lens,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.colorize,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.face,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.favorite,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.favorite_border,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.flip,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.gradient,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.invert_colors,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.local_activity,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.local_offer,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.local_shipping,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.local_taxi,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.mode_edit,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.monochrome_photos,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_album,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_camera,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_library,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_size_select_actual,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_size_select_large,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.photo_size_select_small,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.picture_as_pdf,
  ),
  CategoryIcons(
    category: categorias[ListaDeCategorias.moda.name]!,
    icon: Icons.portrait,
  ),
];
