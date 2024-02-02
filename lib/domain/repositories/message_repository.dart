import '../model/message.dart';

abstract class MessageRepository {
  Future<void> sendMessage(Message message);
  Stream<List<Message>> getMessageStream();
}
