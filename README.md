# CST 438 - *FoodLab*

**FoodLab** is an iOS app utilizing the [Spoonacular API](https://market.mashape.com/spoonacular/recipe-food-nutrition) to allow users to find recipes based on the ingredients they wish to use

Contributors: Francisco Hernandez, Joseph Antongiovanni, Lesley Amezcua, Logan Louks

## User Stories

- [x] User can login using Facebook
- [ ] User can login using Google
- [x] User can search for recipes by ingredient 
- [x] User can search using multiple ingredients
- [x] User sees a collection view of recipe results
- [x] User can see a detail view of recipe results
- [x] Detail view contains ingredient list and cooking instructions


## Video Walkthrough:

Here's a walkthrough of our currently implemented user stories

<img src='https://i.imgur.com/rewxSiQ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

In development recipe details screen

<img src='https://i.imgur.com/Ba54khl.png' title='Detail View' width='' alt='Detail View' />


# How To Use Food Lab:

1. Login to the application by signing in with either Google or FaceBook.
2. Manually type in the ingredients in which you wish to make a meal with. Separate each of the ingredients with a comma  (Example: bacon, eggs, cheese, sausage)
3. The Spoonacular API will generate recipes based on the specific ingredients the user types in.
4. Select a recipe in which you wish to use.
5. Enjoy!

## Motivation:

Being a college student makes it hard to come up with different recipes because we are limited on time. This application will help those who are not creative when it comes to making food with ingredients they have available at home.

Also, as a group we wanted a challenge and develop something on a program in-which none of us have used before. So we all decided on making an iOS application.


## Problem:

Have you ever been in a situation where you wanted to make a delicious meal with certain food ingredients but had no clue the possible dishes you can make with those ingredients?

Food-Lab solves that problem by having users type in specific ingredients and the application provides an abundance of recipes that uses those specific ingredients.


## Technology/Framework Used:

The technologies used in the application 'Food Lab' are:

- [XCode (iOS)](https://developer.apple.com/xcode/): Xcode is an IDE produced by Apple for developing macOS, iOS, and TVOS. We wanted to challenge ourselves as the majority of our group has limited experience with iOS programming. Xcode will be used for both the front-end and back-end of developing FoodLab.

- [FireBase (Database)](https://firebase.google.com/): Firebase Realtime Database is a cloud-hosted database. Data is stored as JSON and synchronized in realtime to every connected client. When you build cross-platform apps with our iOS, Android, and JavaScript SDKs, all of your clients share one Realtime Database instance and automatically receive updates with the newest data.

- [FaceBook (API)](https://developers.facebook.com/docs/) : Facebook login will be used for the user login feature within the “Food Lab” application. Users will be able to create a login by incorporating the users information from Facebook.

- [Google (API)](https://developers.google.com/identity/): A long with FaceBook, Google login will be used for the user login feature within the “Food Lab” application. Users will be able to create a login by incorporating the users information from Google. 

- [Spoonacular Recipe (API)](https://spoonacular.com/food-api/docs/find-recipes-by-ingredients
): Spoonacular lets you find recipes that either maximize the usage of ingredients you have at hand (pre shopping) or minimize the ingredients that you don't currently have (post shopping).

- [GitHub](https://github.com/): GitHub brings together the world's largest community of developers to discover, share, and build better software. From open source projects to private team repositories, we're your all-in-one platform for collaborative development.


## Features:

This project features a variety of technologies that come together in providing an abundance of data for users.Our project stands out because we solved the common problem of users not knowing the possible dishes they can make with the given ingredients that they have. We solved this issue by helping users decide on what to make for a meal based on the ingredients that they have at the home.  


## API Reference:

The three API's that the application 'Food Lab' uses are Spoonacular, FaceBook, and Google. As previously stated Spoonacular is used for finding recipes that either maximize the usage of ingredients. FaceBook and Google are used for the sign-in features of the application.

## GitHub Link:
https://github.com/ciscohern/Food-Lab

## License

    Copyright [2018] [Francisco Hernandez, Joseph Antongiovanni, Lesley Amezcua, Logan Louks]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

---
