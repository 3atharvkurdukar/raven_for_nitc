class DBUser {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final String? mess;

  DBUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
    this.mess,
  });

  factory DBUser.fromMap(Map<String, dynamic> data) {
    return DBUser(
      id: data['id'],
      email: data['email'],
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      mess: data['mess'],
    );
  }
}

class Event {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final String? imageURL;
  final String? venue;
  final String authority;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    this.endTime,
    this.imageURL,
    this.venue,
    required this.authority,
  });

  factory Event.fromMap(Map<String, dynamic> data) {
    return Event(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      startTime: data['startTime'].toDate(),
      endTime: data['endTime'].toDate(),
      venue: data['venue'],
      imageURL: data['imageURL'],
      authority: data['authority'],
    );
  }
}

class Announcement {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime createdAt;
  final String authority;

  Announcement({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.authority,
  });

  factory Announcement.fromMap(Map<String, dynamic> data) {
    return Announcement(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      startTime: data['startTime'].toDate(),
      endTime: data['endTime'].toDate(),
      createdAt: data['createdAt'].toDate(),
      authority: data['authority'],
    );
  }
}

class MessMenu {
  final Map<String, List<String>> breakfast;
  final Map<String, List<String>> lunch;
  final Map<String, List<String>> snacks;
  final Map<String, List<String>> dinner;

  MessMenu({
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
  });

  factory MessMenu.fromMap(Map<String, dynamic> data) {
    return MessMenu(
      breakfast: data['breakfast'],
      lunch: data['lunch'],
      snacks: data['snacks'],
      dinner: data['dinner'],
    );
  }
}

class MessTimetable {
  final String id;
  final String name;
  final bool vegOnly;
  final Map<String, MessMenu> sun;
  final Map<String, MessMenu> mon;
  final Map<String, MessMenu> tue;
  final Map<String, MessMenu> wed;
  final Map<String, MessMenu> thu;
  final Map<String, MessMenu> fri;
  final Map<String, MessMenu> sat;

  MessTimetable({
    required this.id,
    required this.name,
    required this.vegOnly,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
  });

  factory MessTimetable.fromMap(Map<String, dynamic> data) {
    return MessTimetable(
      id: data['id'],
      name: data['name'],
      vegOnly: data['vegOnly'],
      sun: data['sun'],
      mon: data['mon'],
      tue: data['tue'],
      wed: data['wed'],
      thu: data['thu'],
      fri: data['fri'],
      sat: data['sat'],
    );
  }
}

class AmenityTiming {
  final String startTime;
  final String endTime;

  AmenityTiming({
    required this.startTime,
    required this.endTime,
  });

  factory AmenityTiming.fromMap(Map<String, dynamic> data) {
    return AmenityTiming(
      startTime: data['startTime'],
      endTime: data['endTime'],
    );
  }
}

class Amenity {
  final String id;
  final String name;
  final List<AmenityTiming> sun;
  final List<AmenityTiming> mon;
  final List<AmenityTiming> tue;
  final List<AmenityTiming> wed;
  final List<AmenityTiming> thu;
  final List<AmenityTiming> fri;
  final List<AmenityTiming> sat;

  Amenity({
    required this.id,
    required this.name,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
  });

  factory Amenity.fromMap(Map<String, dynamic> data) {
    return Amenity(
      id: data['id'],
      name: data['name'],
      sun: data['sun'],
      mon: data['mon'],
      tue: data['tue'],
      wed: data['wed'],
      thu: data['thu'],
      fri: data['fri'],
      sat: data['sat'],
    );
  }
}
