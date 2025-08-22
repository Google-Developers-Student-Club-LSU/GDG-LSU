//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//





// UPCOMING EVENTS
//Title, Description, Date, Color  is required to create an event
// if time is not yet available please put it less than or equal 30 min gap eg 
//                    (year, month, day, hour, mins) 
//    "date": DateTime(2025, 6, 15, 10, 0),
//    "endDate": DateTime(2025, 6, 15, 10, 30),
// Image, Time, Room number is no required can be update later
// Color Code: 
// General Body Meeting = Green, Workshop = Blue, Major Events = Red, Social Events = gYellow
import 'package:gdgwebsite/Colors.dart';

final List<Map<String, dynamic>> myEvents = [
  {
    "title": "General Body Meeting",
    "date": DateTime(2025, 7, 15, 10, 0),
    "endDate": DateTime(2025, 7, 15, 10, 30),
    "description": "Weekly sync-up with the team to discuss goals.",
    "color": gGreen,
    "room" : "PFT 1200",
  },
    {
    "title": "Engineering Club Fair",
    "date": DateTime(2025, 8, 28, 16, 30),
    "endDate": DateTime(2025, 8, 28, 18, 00),
    "description": "Join Google Developer Group at LSU and be part of a passionate tech community where you can learn, build, and grow alongside fellow students. Look forward to exciting opportunities like our Hackathon, ICPC programming contest, and hands-on workshops. Together, we’ll work on real-world software projects, including building and deploying an app that we’ll actually use, giving you practical experience that goes beyond the classroom. Whether you’re just starting out or looking to sharpen your skills, GDG at LSU is the place to connect, create, and make an impact.",
    "color": gYellow,
    "room" : "Patrick F. Taylor Hall - Cambre Atrium"
  },
  {
    "title": "Career workshop ",
    "date": DateTime(2025, 9, 3, 14, 30),
    "endDate": DateTime(2025, 9, 3, 15,00 ),
    "description": "Join us for a career workshop hosted by FAST ENTERPRISES. Learn about career paths, gain resume and interview tips, and discover internship and job opportunities with a leading tech company.",
    "color": gBlue,
    "room" : "PFT 1202"
  },
  {
    "title": "General Body Meeting",
    "date": DateTime(2025, 9, 15, 12, 0),
    "endDate": DateTime(2025, 9, 15, 12, 30),
    "description": 
    '''Catch up with fellow members as we kick off the semester! We'll discuss plans for our upcoming app development project, assign initial roles, and get things rolling. Plus, enjoy some fun activities to break the ice and build team spirit.''',
    "color": gGreen,
    "room" : "PFT 1209"
  },
    {
    "title": "Game Development Workshop",
    "date": DateTime(2025, 9, 29, 12, 0),
    "endDate": DateTime(2025, 9, 29, 12, 30),
    "description": 
    '''Dive into the world of game development in this hands-on workshop hosted by Lillian, our talented graphic designer. Learn the fundamentals of designing and building simple games, explore visual design principles, and collaborate with peers to bring your ideas to life—no prior experience required!''',
    "color": gBlue,
    "room" : "PFT 1209"
  },
    {
    "title": "GeauxHack",
    "date": DateTime(2025, 11, 7, 18, 00),
    "endDate": DateTime(2025,11, 7, 23, 59),
    "description": '''Join us for an exciting 3-day hackathon hosted in collaboration between SASE and GDG, packed with innovation, creativity, and fun. Designed for all skill levels, the event features two categories: Beginner and Advanced, making it both beginner-friendly and competitively engaging for experienced participants. Enjoy provided meals throughout the weekend, along with engaging activities, networking opportunities, and a collaborative atmosphere. The top teams in each category will earn amazing prizes and recognition, so bring your ideas, your energy, and your team for an unforgettable experience.''',
    "color": gRed,
    "room" : "Patrick F Taylor",
  },
  {
    "title": "GeauxHack",
    "date": DateTime(2025, 11, 8, 00, 00),
    "endDate": DateTime(2025,11, 8, 23, 59),
    "description": '''Join us for an exciting 3-day hackathon hosted in collaboration between SASE and GDG, packed with innovation, creativity, and fun. Designed for all skill levels, the event features two categories: Beginner and Advanced, making it both beginner-friendly and competitively engaging for experienced participants. Enjoy provided meals throughout the weekend, along with engaging activities, networking opportunities, and a collaborative atmosphere. The top teams in each category will earn amazing prizes and recognition, so bring your ideas, your energy, and your team for an unforgettable experience.''',
    "color": gRed,
    "room" : "Patrick F Taylor",
  },
  {
    "title": "GeauxHack",
    "date": DateTime(2025, 11, 9, 00, 00),
    "endDate": DateTime(2025,11, 9, 12, 00),
    "description":'''Join us for an exciting 3-day hackathon hosted in collaboration between SASE and GDG, packed with innovation, creativity, and fun. Designed for all skill levels, the event features two categories: Beginner and Advanced, making it both beginner-friendly and competitively engaging for experienced participants. Enjoy provided meals throughout the weekend, along with engaging activities, networking opportunities, and a collaborative atmosphere. The top teams in each category will earn amazing prizes and recognition, so bring your ideas, your energy, and your team for an unforgettable experience.''',
    "color": gRed,
    "room" : "Patrick F Taylor",
  },
];
