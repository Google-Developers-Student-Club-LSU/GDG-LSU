import 'package:flutter/cupertino.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/Models/MemberModel.dart';

final String home = '/home';
final String events = 'events';
final String eboard = 'eboard';
final String sponsor = 'sponsor';


const double containerWidth = 300;
const double containerHeight = 500;


// EBOARD MEMBERS
final List<MemberProfile> members = [
  MemberProfile(
    fullName: 'Mujtaba Malik',
    position: 'President',
    yearAndMajor: 'Junior Computer Science',
    shortIntro:
    '''
Hi everyone,
I’m Mujtaba Malik, I just go by Malik, and I've got to witness this club rise from the grave in 2023 as well as play a part in helping it regain its standing in 2024. This year,  I plan to keep that momentum going to make the Google Developer Community at Louisiana stronger than it has ever been with the help of some amazing and talented officers who are devoted to pushing the club even further. 

With my leadership experience in other organizations and industry experience in tech roles as well as my passions and knowledge stretching across many domains related to tech such as medicine and financials. I want to bring what I’ve learned in a way that’s engaging and valuable. Expect workshops, career prep, and community-building meetups. I want this club to be a hub—a place where both computer science and non CS students can find their footing. I know how overwhelming this field can feel at first, and I want to help make that path a little less intimidating for everyone here.

Apart from coding, I like One Piece, Cooking, and Working out(honestly, not much else). You can also catch me weightlifting at the UREC from 10-11 pm or at some random spot in the pft.

''',
    linkedin: 'https://www.linkedin.com/in/mujtaba-malik-7b8442299/',
    imageAsset: 'members/Trenton.jpg',
  ),
  MemberProfile(
    fullName: 'Jerrick Miles',
    position: 'Treasurer',
    yearAndMajor: 'Computer Science minor DMAET',
    shortIntro: 'At the heart of everything I do is a simple motto: Build your tomorrow.  My software journey started in middle school, and now as a Computer Science student at LSU, I’m combining software with UX design to create tools that will help people everywhere!',
    linkedin: 'http://linkedin.com/in/jerrick-miles',
    imageAsset: 'members/Jerrick.jpg',
  ),
  MemberProfile(
    fullName: 'Lillian Holliday',
    position: 'Graphic Designer',
    yearAndMajor: 'Sophomore Computer Science',
    shortIntro: 'Hi! My name is Lily, and I’m the graphic designer for GDSC. I create visuals for events, merch, and social media to help bring our club’s ideas to life. As a computer science major here at LSU, creativity is very important, and I enjoy enhancing my coding skills with my background in design.',
    linkedin: 'https://www.linkedin.com/in/lillian-holliday-b6a64a371?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app',
    imageAsset: 'members/Lillian.png',
  ),
    MemberProfile(
    fullName: 'Dina Taing',
    position: 'Web Master',
    yearAndMajor: 'Senior Computer Science',
    shortIntro: "Hi, I’m the Web Master for GDG LSU and the sole developer behind our website. I’m deeply passionate about Go and Flutter for their speed, simplicity, and flexibility. Obsessed with UX and performance, I focus on building fast, intuitive, and polished experiences from backend to frontend. (Fun fact): This website is built entirely with Flutter!",
    linkedin: 'https://www.linkedin.com/in/dina-taing-143935236/',
    imageAsset: 'members/Dina.jpg',
  ),
];





// UPCOMING EVENTS
//Title, Description, Date, Color  is required to create an events 
// if time is not yet available please put it less than or equal 30 min gap eg 
//                  (year, month, day, hour, mins) 
//    "date": DateTime(2025, 6, 15, 10, 0),
//    "endDate": DateTime(2025, 6, 15, 10, 30),
// Image, Time, Room number is no required can be update later

// General Body Meeting = Green, Workshop = Blue, OtherEvents = Red
final List<Map<String, dynamic>> myEvents = [
  {
    "title": "General Body Meeting",
    "date": DateTime(2025, 6, 15, 10, 0),
    "endDate": DateTime(2025, 6, 15, 10, 30),
    "description": "Weekly sync-up with the team to discuss goals.",
    "color": gGreen,
    "room" : "PFT 1200"
  },
  {
    "title": "Firebase WorkShop",
    "date": DateTime(2025, 6, 16, 14, 30),
    "endDate": DateTime(2025, 6, 16, 14, 00),
    "description": "Annual physical check-up at local clinic.",
    "color": gBlue,
    "room" : "PFT 1202"
    

  },
  {
    "title": "Flutter Workshop",
    "date": DateTime(2025, 6, 17, 9, 0),
    "endDate": DateTime(2025, 6, 17, 12, 0),
    "description": 
    '''
Join us for an engaging hands-on workshop where you'll learn how to build modern, responsive mobile apps using Flutter, Google's open-source UI toolkit. Whether you're a beginner or looking to sharpen your cross-platform development skills, this session will guide you through the fundamentals of Dart, Flutter widgets, layouts, and state management.

Bring your laptop and get ready to code!
      ''',
    "image": "events/Flutter.jpg",
    "color": gBlue
    
  },
    {
    "title": "Hackathon",
    "date": DateTime(2025, 6, 30, 14, 30),
    "endDate": DateTime(2025, 6, 30, 15, 30),
    "description": "Annual physical check-up at local clinic.",
    "color": gRed
  },
];
