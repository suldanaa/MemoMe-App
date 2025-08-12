# MemoMe

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

A journal app where you're encouraged to add your entries, and look back on your entries throughout the years.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Lifestyle
- **Mobile:** Real-time logging of your enteries gives this app a particular need for it to be a mobile app. It wouldn't be able to be a website and hold the same purpose.
- **Story:** We live in a time where many life-documentation through apps is common yet based around social engagement. Locket, instagram, snapchat. We have very few apps where the main goal is to document things for your own interest in looking back at what you were thinking earlier in the year.
- **Market:** Those who love journaling and life-documentation, but want a more private and accessible way to do such a thing.
- **Habit:** People will use this to reflect on their day, once a day. Everyday.
- **Scope:** I have a very clear view of the app, since it's built similary to a to-do list we created. I understand how to implement a calender view, persistent data, etc.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can write a note on a specific date
* User can a save note on a specific date
* User can view notes associated with certain date

**Optional Nice-to-have Stories**
* User can view entry stats (e.g. most written month)
* User can add location information to their entries
* User can select different visual themes for the app
* Users can take photos and have them associated with the notes

### 2. Screen Archetypes
- [X] Notes screen
* User can take notes
- [X] Calender view
* User can view past photo+text entries

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Text notes
* Calender view

**Flow Navigation** (Screen to Screen)

- [X] Text notes
        => Calender

## Wireframes

[Add picture of your hand sketched wireframes in this section]
<img src="https://i.ibb.co/cSfmYL3r/Screenshot-2025-08-12-at-10-29-42-AM.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups


### [BONUS] Interactive Prototype

## Schema

#### `DiaryEntry`
A struct representing a diary entry with the following properties:

- `id: String` – Unique identifier for the entry (`UUID`)
- `content: String` – The text content of the diary entry
- `date: Date` – The date the entry is associated with
- `createdDate: Date` – When the entry was first created

**Methods:**
- `save()` – Saves or updates the entry in `UserDefaults`
- `static getEntries()` – Retrieves all saved entries
- `static getEntries(for: Date)` – Gets entries for a specific date
- `static save(_:)` – Saves an array of entries

---

### **Views / Controllers**

#### `CalendarViewController`
- Displays a calendar using `UICalendarView`
- Shows decorations (book icons) for dates with entries
- Allows selecting dates to view corresponding diary entries
- Displays entry content when a date is selected

#### `NotesViewController`
- Provides a text view for writing/editing diary entries
- Includes a date picker to select/create entries for different dates
- Handles saving/updating entries
- Shows placeholder text when no content exists

---

### **Networking**
This application currently uses local storage only (`UserDefaults`) and doesn't have anything for networking.  
All data persistence is handled through:
- `UserDefaults` for storing diary entries
- JSON encoding/decoding of the `DiaryEntry` model

**Potential future networking features:**
- Cloud synchronization (iCloud, Firebase, etc.)
- Backup/restore functionality
- Multi-device support
