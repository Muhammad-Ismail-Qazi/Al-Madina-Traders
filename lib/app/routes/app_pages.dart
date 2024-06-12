import 'package:get/get.dart';

import 'package:al_madina_traders/app/modules/add_product/bindings/add_product_binding.dart';
import 'package:al_madina_traders/app/modules/add_product/views/add_product_view.dart';
import 'package:al_madina_traders/app/modules/cart/bindings/cart_binding.dart';
import 'package:al_madina_traders/app/modules/cart/views/cart_view.dart';
import 'package:al_madina_traders/app/modules/home/bindings/home_binding.dart';
import 'package:al_madina_traders/app/modules/home/views/home_view.dart';
import 'package:al_madina_traders/app/modules/limited_product/bindings/limited_product_binding.dart';
import 'package:al_madina_traders/app/modules/limited_product/views/limited_product_view.dart';
import 'package:al_madina_traders/app/modules/remaing_amounts/bindings/remaing_amounts_binding.dart';
import 'package:al_madina_traders/app/modules/remaing_amounts/views/remaing_amounts_view.dart';
import 'package:al_madina_traders/app/modules/sold_product/bindings/sold_product_binding.dart';
import 'package:al_madina_traders/app/modules/sold_product/views/sold_product_view.dart';
import 'package:al_madina_traders/app/modules/splash/views/splash_view.dart';
import 'package:al_madina_traders/app/modules/today_investment/bindings/today_investment_binding.dart';
import 'package:al_madina_traders/app/modules/today_investment/views/today_investment_view.dart';
import 'package:al_madina_traders/app/modules/today_sold/bindings/today_sold_binding.dart';
import 'package:al_madina_traders/app/modules/today_sold/views/today_sold_view.dart';
import 'package:al_madina_traders/app/modules/track record/bindings/track_record_binding.dart';
import 'package:al_madina_traders/app/modules/track record/views/track_record_view.dart';
import 'package:al_madina_traders/app/modules/view_product/bindings/view_product_binding.dart';
import 'package:al_madina_traders/app/modules/view_product/views/view_product_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
      binding: AddProductBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: _Paths.VIEW_PRODUCT,
      page: () => ViewProductView(),
      binding: ViewProductBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: _Paths.LIMITED_PRODUCT,
      page: () => LimitedProductView(),
      binding: LimitedProductBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 2),
    ),
    GetPage(
      name: _Paths.SOLD_PRODUCT,
      page: () => SoldProductView(),
      binding: SoldProductBinding(),
    ),
    GetPage(
      name: _Paths.TODAY_INVESTMENT,
      page: () => TodayInvestmentView(),
      binding: TodayInvestmentBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.TODAY_SOLD,
      page: () => TodaySoldView(),
      binding: TodaySoldBinding(),
    ),
    GetPage(
      name: _Paths.REMAING_AMOUNTS,
      page: () => RemaingAmountsView(),
      binding: RemaingAmountsBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_RECORD,
      page: () => TrackRecordView(),
      binding: TrackRecordBinding(),
    ),
  ];
}
