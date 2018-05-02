// https://github.com/nodatime/nodatime/blob/master/src/NodaTime.Test/LocalDateTest.cs
// 773f136  on Nov 8, 2017

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

/// <summary>
/// Using the default constructor is equivalent to January 1st 1970, UTC, ISO calendar
/// </summary>
@Test()
void DefaultConstructor()
{
  // todo: new LocalDate()
  var actual = new LocalDate(1, 1, 1);
  expect(new LocalDate(1, 1, 1), actual);
}

@Test()
void CombinationWithTime()
{
  // Test all three approaches in the same test - they're logically equivalent.
  var calendar = CalendarSystem.Julian;
  LocalDate date = new LocalDate.forCalendar(2014, 3, 28, calendar);
  LocalTime time = new LocalTime(20, 17, 30);
  LocalDateTime expected = new LocalDateTime.fromYMDHMSC(2014, 3, 28, 20, 17, 30, calendar);
  // expect(expected, date + time);
  expect(expected, date.At(time));
  expect(expected, time.On(date));
}

@Test()
void Construction_NullCalendar_Throws()
{
  expect(() => new LocalDate.forCalendar(2017, 11, 7, null), throwsArgumentError, reason: "Basic construction.");
  expect(() => new LocalDate.forEra(Era.Common, 2017, 11, 7, null), throwsArgumentError, reason: "Construction including era.");
}

@Test()
void MaxIsoValue()
{
  var value = LocalDate.MaxIsoValue;
  expect(CalendarSystem.Iso, value.Calendar);
  expect(() => value.PlusDays(1), throwsRangeError);
}

@Test()
void MinIsoValue()
{
  var value = LocalDate.MinIsoValue;
  expect(CalendarSystem.Iso, value.Calendar);
  expect(() => value.PlusDays(-1), throwsRangeError);
}