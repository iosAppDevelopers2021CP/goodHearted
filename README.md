Original App Design Project - README Template
===

# GoodHearted

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
GoodHearted is an app that users can press one button for emergency call when help is needed. Users who are on a user’s emergency contact list will be notified; as well as app users who are nearby will be notified.

### App Evaluation
- **Category:** Utilities
- **Mobile:** Mobile App (iOS only) for now. However, this app can be expanded to Android users as well.
- **Story:** People in distress can seek immediate help by clicking the Emergency button and notify nearby users and emergency contacts (friends and family). They can also use the map feature to locate other users in the same location and come help others if needed.
- **Market:** It is designed for all people who seek help when they feel unsafe in public or even at their own home. People from minority groups may find this app helpful, especially during this tough time.
- **Habit:** This app can be used whenever a person feels that they are in danger. For those who go to school/work or run errands on a daily basis, this app can be used regularly as well.
- **Scope:** This app can send notifications to people nearby who are in the vicinity of the threat and also use GPS to notify the friends and family of the user's location.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [ ] User Registration
- [ ] User Login & Stay Login
- [ ] User Logout 
- [ ] Add Emergency contacts
- [ ] Edit User Profile
- [ ] Edit Emergency contacts
- [ ] Edit Settings
- [ ] Notifications

**Optional Nice-to-have Stories**

- [ ] Ringtone/Alarm sounds
- [ ] Upload Profile Picture
- [ ] Direct map to Google Map through API
- [ ] Chat with the contacts in a messenger style
- [ ] make posts like instagram
- [ ] Able to Call 911 when help button is pressed
- [ ] Home Screen Widget

### 2. Screen Archetypes

* Care Caller & Helper
   * Login
   * Register
   * Home Screen with Map
   * Add Emergency Contact Screen

### 3. Navigation

**Navigation Bar** (Tab to Screen)

* Notification Screen
* Settings Screen

**Tab Bar** (Tab to Screen)

* Home Screen
* Profile Screen

**Flow Navigation** (Screen to Screen)

* Launch Screen -> Sign In Screen
   * Sign In (successfully) -> Home Screen
   * Sign Up -> Add Emergency Contact Screen
   * Add Emergency Contact Screen (successfully) -> Home Screen
   * Sign Up (successfully) -> Home Screen
* Home Screen
   * Home Screen -> Profile Screen
   * Home Screen -> Notification Screen
   * Home Screen -> Settings Screen
* Settings Screen
   * Settings Screen -> Update Profile
   * Settings Screen -> Update Emergency Contacts

## Wireframes
<img width="900" alt="Screen Shot 2021-03-30 at 4 55 49 PM" src="https://user-images.githubusercontent.com/67810546/113071112-f1935600-9178-11eb-8722-af4d7d1c368a.png">

### [BONUS] Digital Wireframes & Mockups

**Caller Screen**

<img width="900" alt="Screen Shot 2021-03-30 at 5 03 01 PM" src="https://user-images.githubusercontent.com/67810546/113071550-d412bc00-9179-11eb-816e-e7721ce57a76.png">

**Helper Screen**

<img width="900" alt="Screen Shot 2021-03-30 at 5 00 43 PM" src="https://user-images.githubusercontent.com/67810546/113071415-89913f80-9179-11eb-8ad5-5ad4a3937046.png">

### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/5y1SmLhYG6.gif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src="http://g.recordit.co/m1QJv2dZhU.gif">


## Schema 

### Models

**Sign Up**
| Property | Type | Description  |
| --- |---| ---|
| FullName | String | Full name of the User |
| Email | String | Email address of the User |
| Username | String | Unique username of the User |
| Password | String | User's password |
| Phone | String | User's phone number |
| isTermsAccepted | Boolean | Did the User agree to the Terms and Conditions? |


**Emergency Contact**

| Property        | Type          | Description  |
| --- |---| ---|
| UserName | String | Unique user name for each user |
| UserPhone | Number | User's phone number |
| UserEmail | String | User's email address |
| isMessage | Boolean | User's prefer method of contact |
| isCall | Boolean | User's prefer method of contact |

### Networking
**List of network requests by screen**

* Login Screen
  * Sign Up for new users
  * Sign in for existing users


&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img width="376" alt="Screen Shot 2021-04-15 at 12.58.14 AM.png" src="https://github.com/iosAppDevelopers2021CP/goodHearted/blob/035c6510b50677169fae1271b653a65b1852cb84/Screen%20Shot%202021-04-15%20at%2011.53.33%20AM.png">


* Emergency Contact Screen
  * Add emergency contact information
  * Update emergency contact information


&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img width="376" alt="Screen Shot 2021-04-11 at 7 07 33 PM" src="https://user-images.githubusercontent.com/67810546/114331686-6a8b9980-9af9-11eb-9efd-91aa07e09194.png">


