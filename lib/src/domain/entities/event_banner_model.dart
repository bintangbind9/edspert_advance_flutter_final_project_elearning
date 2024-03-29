class EventBanner {
  final String? eventId;
  final String? eventTitle;
  final String? eventDescription;
  final String? eventImage;
  final String? eventUrl;

  EventBanner({
    this.eventId,
    this.eventTitle,
    this.eventDescription,
    this.eventImage,
    this.eventUrl,
  });

  factory EventBanner.fromJson(Map<String, dynamic> json) => EventBanner(
        eventId: json["event_id"],
        eventTitle: json["event_title"],
        eventDescription: json["event_description"],
        eventImage: json["event_image"],
        eventUrl: json["event_url"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_title": eventTitle,
        "event_description": eventDescription,
        "event_image": eventImage,
        "event_url": eventUrl,
      };
}
