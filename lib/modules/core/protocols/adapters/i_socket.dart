abstract interface class ISocket {
  void joinRoom(String roomId);
  void clear();
  void showVotes();
  void isSpectator();
  void changeDeckOfCards(String deckOfCards);
  void newRoom();
  void vote(String? vote);
  void listAllRooms();
}
