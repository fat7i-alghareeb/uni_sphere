part of 'announcement_bloc.dart';

abstract class AnnouncementEvent {}

final class GetAnnouncementEvent extends AnnouncementEvent {}

final class GetMyAnnouncementEvent extends AnnouncementEvent {}