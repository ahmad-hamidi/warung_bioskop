import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'redirection_ticket_page.g.dart';

@Riverpod(keepAlive: true)
class RedirectionTicketPage extends _$RedirectionTicketPage {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> openPage() async {
    state = const AsyncData(true);
  }

  Future<void> reset() async {
    state = const AsyncData(false);
  }
}
