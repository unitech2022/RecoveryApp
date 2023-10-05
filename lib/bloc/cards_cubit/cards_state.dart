part of 'cards_cubit.dart';

class CardsState extends Equatable {
  final CardResponse? cardResponse;

  final RequestState? getCardsState;

  final RequestState? paymentConfirmState;
  final String paymentMessage;
  const CardsState(
      {this.cardResponse, this.getCardsState, this.paymentConfirmState,this.paymentMessage="waiting ...."});

  CardsState copyWith(
          {final RequestState? paymentConfirmState,
          final RequestState? getCardsState,
           final String? paymentMessage,
          final CardResponse? cardResponse}) =>
      CardsState(
        cardResponse: cardResponse ?? this.cardResponse,
        getCardsState: getCardsState ?? this.getCardsState,
              paymentMessage: paymentMessage ?? this.paymentMessage,
        paymentConfirmState: paymentConfirmState ?? this.paymentConfirmState,
      );

  @override
  List<Object?> get props => [cardResponse, getCardsState, paymentConfirmState,paymentMessage];
}
