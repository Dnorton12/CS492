import 'package:test/test.dart';
import '../models/post_fields.dart';

void main() {
  test('Post created from Map should have appropriate values', ()
  {
    final date = DateTime.parse('2022-01-01').toString();
    const items = '999';
    const latitude = '1.0';
    const longitude = '2.0';
    const url = 'www.google.com';

    final post_fields = PostFields(date: date,
        items: items,
        latitude: latitude,
        longitude: longitude,
        url: url);

    expect(post_fields.date, date);
    expect(post_fields.items, items);
    expect(post_fields.latitude, latitude);
    expect(post_fields.longitude, longitude);
    expect(post_fields.url, url);
  });
}