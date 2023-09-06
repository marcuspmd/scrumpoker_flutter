import 'package:scrumpoker_flutter/atoms/core_atom.dart';
import 'package:scrumpoker_flutter/modules/core/protocols/adapters/i_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketImpl implements ISocket {
  final IO.Socket socket;

  SocketImpl(this.socket) {
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('newRoom', (data) {
      joinRoomAction.value = data;
    });

    socket.on('userJoined', (data) {
      print('user $data');
    });

    socket.on('userLeft', (data) {
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
      print('showVotes $data');
    });

    socket.on('isSpectator', (data) {
      print('isSpectator $data');
    });

    socket.on('sd', (data) {
      print('sd $data');
    });

    socket.on('listAllRooms', (data) {
      print('listAllRooms $data');
    });

    socket.onConnect((_) {
      print('Connection established');
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
  void listAllRooms() {
    socket.emit('listAllRooms');
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
}
