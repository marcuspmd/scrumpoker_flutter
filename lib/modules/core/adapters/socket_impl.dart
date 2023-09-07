import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/i_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketImpl implements ISocket {
  final IO.Socket socket;

  SocketImpl({required this.socket}) {
    connect();
    socket.on('newRoom', (data) {
      joinRoomAction.value = data;
    });

    socket.on('userJoined', (data) {
      addUserAction.value = data;
      print('user $data');
    });

    socket.on('userLeft', (data) {
      removeUserAction.value = data;
      print('userLeft $data');
    });

    socket.on('voted', (data) {
      userVoted.value = data;
      print('voted $data');
    });

    socket.on('clear', (data) {
      clearAction();
      print('clear $data');
    });

    socket.on('roomDetail', (data) {
      print('data $data');
      updateUsers.value = data;
    });

    socket.on('id', (data) {
      myUserIdState.value = data;
    });

    socket.on('showVotes', (data) {
      updateUsers.value = data;
      print('showVotes $data');
    });

    socket.on('isSpectator', (data) {
      updateSpectator.value = data;
      print('isSpectator $data');
    });

    socket.on('sd', (data) {
      updateSd.value = data;
      print('sd $data');
    });
  }

  @override
  void joinRoom(String roomId) {
    socket.emit('joinRoom', {'room': roomId});
  }

  @override
  void newRoom() {
    socket.emit('newRoom');
  }

  @override
  void vote(String? vote) {
    socket.emit('vote', vote);
  }

  @override
  void changeDeckOfCards(String deckOfCards) {
    socket.emit('changeDeckOfCards', {'deckOfCards': deckOfCards});
  }

  @override
  void isSpectator() {
    socket.emit('isSpectator');
  }

  @override
  void showVotes() {
    socket.emit('showVotes');
  }

  @override
  void clear() {
    socket.emit('clear');
  }

  @override
  void connect() async {
    loadingState.value = true;
    if (socket.id != null) {
      socket.disconnect();
    }
    socket.connect();
    while (!socket.connected) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    loadingState.value = false;
  }
}
