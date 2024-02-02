import '../model/message.dart';
import '../repositories/message_repository.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase(this.messageRepository);

  Future<void> sendMessage(
      String text, String userId, String username, String userImage) async {
    // Implement send message logic here using MessageRepository
    final message = Message(
      id: '',
      text: text,
      userId: userId,
      username: username,
      userImage: userImage,
    );
    await messageRepository.sendMessage(message);
  }
}
