import 'User_Model.dart';

class Message {
  final UserModel sender;
  final String time;
  final String text;
  final bool isLiked;
  late final bool unread;

  Message(
      {required this.sender,
      required this.time,
      required this.text,
      required this.isLiked,
      required this.unread});
}

final UserModel currentUser = UserModel(
    kAdi: 'currentUser',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'currentUser',
    imageUrl: 'https://randomuser.me/api/portraits/women/19.jpg');

final UserModel greg = UserModel(
    kAdi: 'greg',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'greg',
    imageUrl: 'https://randomuser.me/api/portraits/men/93.jpg');

final UserModel wish = UserModel(
    kAdi: 'wish',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'wish',
    imageUrl: 'https://randomuser.me/api/portraits/men/13.jpg');

final UserModel boston = UserModel(
    kAdi: 'boston',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'boston',
    imageUrl: 'https://randomuser.me/api/portraits/women/46.jpg');

final UserModel captain = UserModel(
    kAdi: 'captain',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'captain',
    imageUrl: 'https://randomuser.me/api/portraits/women/18.jpg');

final UserModel kolony = UserModel(
    kAdi: 'kolony',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'kolony',
    imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg');

final UserModel cristie = UserModel(
    kAdi: 'cristie',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'cristie',
    imageUrl: 'https://randomuser.me/api/portraits/women/66.jpg');

final UserModel umo = UserModel(
    kAdi: 'umo',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'Ümit',
    imageUrl: 'https://randomuser.me/api/portraits/men/53.jpg');

final UserModel gaz = UserModel(
    kAdi: 'gaz',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'Gamze',
    imageUrl: 'https://randomuser.me/api/portraits/women/27.jpg');

final UserModel cake = UserModel(
    kAdi: 'cake',
    mail: 'gergo@dfsdf',
    tel: '05554512364',
    displayName: 'Cello',
    imageUrl: 'https://randomuser.me/api/portraits/men/96.jpg');

List<UserModel> favorites = [boston, captain, wish, gaz,umo,cake,kolony];

List<Message> chats = [
  Message(
      sender: captain,
      time: '05.20',
      text: 'Hello Have a nice day dear',
      isLiked: false,
      unread: false),
  Message(
      sender: currentUser,
      time: '05.35',
      text: 'Gamze bak bu programı indirecen söz ver',
      isLiked: false,
      unread: true),
  Message(
      sender: wish,
      time: '03.50',
      text: 'Custumers Are very guilty about that',
      isLiked: false,
      unread: true),
  Message(
      sender: cristie,
      time: '18.16',
      text: 'I want to say Love you to her but ı dont attempt',
      isLiked: true,
      unread: false),
  Message(
      sender: greg,
      time: '01.45',
      text:
          'My love is very interesting ı dont understood what he loves me or not',
      isLiked: false,
      unread: true),
  Message(
      sender: umo,
      time: '22.45',
      text: "Hey Gamze whats up did you listen music which I sent",
      isLiked: true,
      unread: true),
  Message(
      sender: gaz,
      time: '23.55',
      text:
          "Not yet dear we're talking about life and they are drunk now,I'll listen I promise",
      isLiked: true,
      unread: true),
  Message(
      sender: cake,
      time: '23.01',
      text: "I'm from Kırozane and I'm talking about women all the time ",
      isLiked: true,
      unread: true),
];
List<Message> messages = [
  Message(
    sender: umo,
    time: '5:30 PM',
    text: 'Gamze Bu Programı İndir Bak',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: gaz,
    time: '4:30 PM',
    text: 'Tamam tamam indirecez anladık',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: umo,
    time: '3:45 PM',
    text: 'Senin Adını Buldum gız Senin Adın Bundan Kelli Cannooooo',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: umo,
    time: '3:15 PM',
    text: 'K1R4L ',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Kendi Kendime Senin adına mesaj yazmak ta ne bileiym',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: gaz,
    time: '2:00 PM',
    text: 'Saçma sapan mesajlar :))',
    isLiked: false,
    unread: true,
  ),
];
