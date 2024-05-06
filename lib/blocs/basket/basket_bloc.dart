import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_event.dart';
import 'package:gavhar_app/blocs/basket/basket_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/sql_data/local_data.dart';

class BasketProductBloc extends Bloc<BasketEvent, BasketState> {
  BasketProductBloc()
      : super(
          BasketState(
              errorStatus: "",
              products: [],
              fromStatus: FromStatus.pure,
              errorString: ""),
        ) {
    on<AddProductToBasketEvent>(_insertToBasketProduct);
  }

  _insertToBasketProduct(AddProductToBasketEvent event, emit) async {
    NetworkResponse networkResponse = await LocalDatabase.
  }
}
