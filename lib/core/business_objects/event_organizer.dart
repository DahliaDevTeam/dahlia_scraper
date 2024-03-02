import 'package:equatable/equatable.dart';

final class EventOrganizer extends Equatable {

  final String uid;
  final String name;
  final int followers;
  final int events;

  EventOrganizer({
    required this.uid,
    required this.name,
    required this.followers,
    required this.events,
  });

  @override
  List<Object?> get props => [
    uid,
    name,
    followers,
    events,
  ];

}