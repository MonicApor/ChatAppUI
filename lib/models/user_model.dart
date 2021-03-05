class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Kim Namjoon',
  imageUrl: 'assets/images/namjoon.jpg',
  isOnline: true,
);

// USERS
final User kimSeokjin = User(
  id: 1,
  name: 'Kim SeokJin',
  imageUrl: 'assets/images/jin.jpg',
  isOnline: true,
);
final User minyoongi = User(
  id: 2,
  name: 'Min Yoongi',
  imageUrl: 'assets/images/suga.jpg',
  isOnline: true,
);
final User jhope = User(
  id: 3,
  name: 'Jung Hoseok',
  imageUrl: 'assets/images/j-hope.jpg',
  isOnline: false,
);
final User jimin = User(
  id: 4,
  name: 'Park Jimin',
  imageUrl: 'assets/images/jimin.jpg',
  isOnline: false,
);
final User kimTaehyung = User(
  id: 5,
  name: 'Kim Taehyung',
  imageUrl: 'assets/images/taehyung.jpg',
  isOnline: true,
);
final User jungkook = User(
  id: 6,
  name: 'Jeon Jung-Kook',
  imageUrl: 'assets/images/jungkook.jpg',
  isOnline: false,
);
final User jongsuk = User(
  id: 7,
  name: 'Lee Jong Suk',
  imageUrl: 'assets/images/jong-suk.jpg',
  isOnline: false,
);
final User minho = User(
  id: 8,
  name: 'Lee Min-Ho',
  imageUrl: 'assets/images/minho.jpg',
  isOnline: true,
);
