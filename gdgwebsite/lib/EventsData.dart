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
    "title": "General Body Meeting",
    "date": DateTime(2025, 9, 10, 17, 30),
    "endDate": DateTime(2025, 9, 10, 18, 30),
    "description": 
    '''Catch up with fellow members as we kick off the semester! We'll discuss plans for our upcoming app development project, assign initial roles, and get things rolling. Plus, enjoy some fun activities to break the ice and build team spirit.''',
    "color": gGreen,
    "image": "assets/events/GBM1.png",
    "room" : "PFT 1209"
  },
    {
    "title": "App Development Meet",
    "date": DateTime(2025, 9, 16, 12, 0),
    "endDate": DateTime(2025, 9, 16, 12, 30),
    "description": "Join us as we officially kick off our app development project! In this session, we’ll align on the core idea, finalize the project scope, and start dividing tasks across the team. This is our first step toward building something great together—let’s collaborate, plan effectively, and set the foundation for a successful launch.",
    "color": gRed,
    "image": "assets/events/appDev1.png",
  
  // "room" : "PFT 1209"
  },
      {
    "title": "C++ Workshop",
    "date": DateTime(2025, 9, 18, 12, 0),
    "endDate": DateTime(2025, 9, 18, 12, 30),
    "description": '''Get ready to explore the power of C++ in this interactive workshop! We'll cover everything from core syntax and object-oriented programming to practical use cases and problem-solving techniques. Whether you're just starting out or looking to deepen your knowledge, this session offers something for everyone. Learn, code, collaborate, and take your C++ skills to the next level.''',
    "color": gBlue,
  
  // "room" : "PFT 1209"
  },
      {
    "title": "LeetCode Workshop",
    "date": DateTime(2025, 10, 13, 12, 0),
    "endDate": DateTime(2025, 10, 13, 12, 30),
    "description": "Sharpen your coding skills and boost your problem-solving game with our LeetCode Workshop! This session focuses on tackling popular coding challenges, exploring efficient algorithms, and sharing strategies to ace technical interviews. Whether you're preparing for placements or just love solving problems, this workshop is the perfect place to level up and learn with peers.",
    "color": gBlue,
  
  // "room" : "PFT 1209"
  },
  {
    "title": "Move Night",
    "date": DateTime(2025, 10, 21, 12, 0),
    "endDate": DateTime(2025, 10, 21, 12, 30),
    "description": "Let’s take a break from the grind and enjoy a fun, laid-back evening together! We’ll be watching The Social Network — a fast-paced, inspiring film about ambition, innovation, and the origins of Facebook. It’s the perfect chance to relax, have some laughs, and connect with friends and teammates over a great movie. Come for the film, stay for the good vibes!",
    "color": gYellow,
  
  // "room" : "PFT 1209"
  },
  {
    "title": "Web Development Workshop",
    "date": DateTime(2025, 10, 27, 12, 0),
    "endDate": DateTime(2025, 10, 27, 12, 30),
    "description": '''
Hosted by Hudson (Vice President – Frontend) & Dina Taing (Webmaster – Backend)

Dive into the world of web development with a dynamic workshop led by our very own Hudson and Dina! This session is designed to give you a complete front-to-back understanding of how websites come to life — from stunning user interfaces to powerful server-side functionality.

You’ll get to see how frontend and backend work hand-in-hand, learn the basics of collaboration in a dev team, and pick up essential skills to prepare for the upcoming hackathon. Whether you're new to web dev or looking to sharpen your skills, this is a great opportunity to learn, connect, and get inspired!
''',
    "color": gBlue,
  
  // "room" : "PFT 1209"
  },
  {
    "title": "GitHub Workshop",
    "date": DateTime(2025, 11, 3, 12, 0),
    "endDate": DateTime(2025, 11, 3, 12, 30),
    "description": '''
Get Hackathon-Ready!

Master the essential tool every developer needs — GitHub! This workshop will walk you through version control basics, branching, pull requests, and effective collaboration workflows to help you contribute confidently to any team project.

Perfect for beginners and a solid refresher for experienced devs, this session will get you fully prepped to work seamlessly with your team during the upcoming hackathon. Let’s build smarter, together!
''',
    "color": gBlue,
  
  // "room" : "PFT 1209"
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
    {
    "title": "2nd General Body Meeting",
    "date": DateTime(2025, 12, 1, 12, 00),
    "endDate": DateTime(2025,12, 1, 12, 30),
    "description":
    '''
Reflect, Celebrate, and Share the Feast!

Come join us for the final General Body Meeting of the year and semester, where we’ll celebrate all we’ve achieved as a team and a club! From our app development milestones to the overall growth we’ve seen, we’ll reflect on the hard work and dedication that made it all happen.

In addition to the celebrations, we’ll recognize the standout contributors to our app development project, highlighting those who truly made a difference.

And of course, it wouldn’t be a proper celebration without food! Bring your favorite dish to share at our Potluck — a perfect way to connect, unwind, and enjoy some delicious treats together as we wrap up the year.
''',
    "color": gGreen,
    "room" : "Patrick F Taylor",
  },
];
