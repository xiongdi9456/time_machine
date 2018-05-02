import 'dart:async';

import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_calendars.dart';
import 'package:time_machine/time_machine_utilities.dart';

import 'package:test/test.dart';
import 'package:matcher/matcher.dart';
import 'package:time_machine/time_machine_timezones.dart';

import 'time_machine_testing.dart';

Future main() async {
  await runTests();
}

@Test()
void StartOfMonth()
{
  var start = new LocalDate(2014, 6, 27);
  var end = new LocalDate(2014, 6, 1);
  expect(end, DateAdjusters.StartOfMonth(start));
}

@Test()
void EndOfMonth()
{
  var start = new LocalDate(2014, 6, 27);
  var end = new LocalDate(2014, 6, 30);
  expect(end, DateAdjusters.EndOfMonth(start));
}

@Test()
void DayOfMonth()
{
  var start = new LocalDate(2014, 6, 27);
  var end = new LocalDate(2014, 6, 19);
  var adjuster = DateAdjusters.DayOfMonth(19);
  expect(end, adjuster(start));
}

@Test()
@TestCase(const [2014, 8, 18, IsoDayOfWeek.monday, 2014, 8, 18], "Same day-of-week")
@TestCase(const [2014, 8, 18, IsoDayOfWeek.tuesday, 2014, 8, 19])
@TestCase(const [2014, 8, 18, IsoDayOfWeek.sunday, 2014, 8, 24])
@TestCase(const [2014, 8, 31, IsoDayOfWeek.monday, 2014, 9, 1], "Wrap month")
void NextOrSame(
    int year, int month, int day, IsoDayOfWeek dayOfWeek,
    int expectedYear, int expectedMonth, int expectedDay)
{
  LocalDate start = new LocalDate(year, month, day);
  LocalDate actual = start.With(DateAdjusters.NextOrSame(dayOfWeek));
  LocalDate expected = new LocalDate(expectedYear, expectedMonth, expectedDay);
  expect(expected, actual);
}

@Test()
@TestCase(const [2014, 8, 18, IsoDayOfWeek.monday, 2014, 8, 18], "Same day-of-week")
@TestCase(const [2014, 8, 18, IsoDayOfWeek.tuesday, 2014, 8, 12])
@TestCase(const [2014, 8, 18, IsoDayOfWeek.sunday, 2014, 8, 17])
@TestCase(const [2014, 8, 1, IsoDayOfWeek.thursday, 2014, 7, 31], "Wrap month")
void PreviousOrSame(
    int year, int month, int day, IsoDayOfWeek dayOfWeek,
    int expectedYear, int expectedMonth, int expectedDay)
{
  LocalDate start = new LocalDate(year, month, day);
  LocalDate actual = start.With(DateAdjusters.PreviousOrSame(dayOfWeek));
  LocalDate expected = new LocalDate(expectedYear, expectedMonth, expectedDay);
  expect(expected, actual);
}

@Test()
@TestCase(const [2014, 8, 18, IsoDayOfWeek.monday, 2014, 8, 25], "Same day-of-week")
@TestCase(const [2014, 8, 18, IsoDayOfWeek.tuesday, 2014, 8, 19])
@TestCase(const [2014, 8, 18, IsoDayOfWeek.sunday, 2014, 8, 24])
@TestCase(const [2014, 8, 31, IsoDayOfWeek.monday, 2014, 9, 1], "Wrap month")
void Next(
    int year, int month, int day, IsoDayOfWeek dayOfWeek,
    int expectedYear, int expectedMonth, int expectedDay)
{
  LocalDate start = new LocalDate(year, month, day);
  LocalDate actual = start.With(DateAdjusters.Next(dayOfWeek));
  LocalDate expected = new LocalDate(expectedYear, expectedMonth, expectedDay);
  expect(expected, actual);
}

@Test()
@TestCase(const [2014, 8, 18, IsoDayOfWeek.monday, 2014, 8, 11], "Same day-of-week")
@TestCase(const [2014, 8, 18, IsoDayOfWeek.tuesday, 2014, 8, 12])
@TestCase(const [2014, 8, 18, IsoDayOfWeek.sunday, 2014, 8, 17])
@TestCase(const [2014, 8, 1, IsoDayOfWeek.thursday, 2014, 7, 31], "Wrap month")
void Previous(
    int year, int month, int day, IsoDayOfWeek dayOfWeek,
    int expectedYear, int expectedMonth, int expectedDay)
{
  LocalDate start = new LocalDate(year, month, day);
  LocalDate actual = start.With(DateAdjusters.Previous(dayOfWeek));
  LocalDate expected = new LocalDate(expectedYear, expectedMonth, expectedDay);
  expect(expected, actual);
}

@Test()
void Month_Valid()
{
  var adjuster = DateAdjusters.Month(2);
  var start = new LocalDate.forCalendar(2017, 8, 21, CalendarSystem.Julian);
  var actual = start.With(adjuster);
  var expected = new LocalDate.forCalendar(2017, 2, 21, CalendarSystem.Julian);
  expect(expected, actual);
}

@Test()
void Month_InvalidAdjustment()
{
  var adjuster = DateAdjusters.Month(2);
  var start = new LocalDate.forCalendar(2017, 8, 30, CalendarSystem.Julian);
  // Assert.Throws<ArgumentOutOfRangeException>(() => start.With(adjuster));
  expect(() => start.With(adjuster), throwsRangeError);
}

@Test()
void IsoDayOfWeekAdjusters_Invalid()
{
  var invalid = new IsoDayOfWeek (10); //IsoDayOfWeek) 10;
  //Assert.Throws<ArgumentOutOfRangeException>(() => DateAdjusters.Next(invalid));
  //Assert.Throws<ArgumentOutOfRangeException>(() => DateAdjusters.NextOrSame(invalid));
  //Assert.Throws<ArgumentOutOfRangeException>(() => DateAdjusters.Previous(invalid));
  //Assert.Throws<ArgumentOutOfRangeException>(() => DateAdjusters.PreviousOrSame(invalid));
  expect(() => DateAdjusters.Next(invalid), throwsRangeError);
  expect(() => DateAdjusters.NextOrSame(invalid), throwsRangeError);
  expect(() => DateAdjusters.Previous(invalid), throwsRangeError);
  expect(() => DateAdjusters.PreviousOrSame(invalid), throwsRangeError);
}