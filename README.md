# AdVancediOS_SoulDates_Ass1

Github repository link: https://github.com/choc0099/AdVancediOS_SoulDates_Ass2
Note that the project may take under a minute to load in a simulator because it is a large project.

# Introduction
This is an online dating app with limited is simplified but does not have all the features that you would expect from other dating apps. For instance, it does not use email addresses and passwords to register nor it does not have a chat feature.

This is just a prototype to share my ideas of what I want the dating app to have.

# Features

The app containts the following features including

## Easy to navigate during the onboaring Process:
The onboarding process was styled with a ScrollView and a VStack with text and UI elements being centered and have a large buttons which makes it eaiser for people with disabilities to navigate.

## Filering matches
During the onboarding process, MatchSeekers can set their dating preferences including who they are interested in and if they want to date people with disabilties or not or even both.

Once they set the dating prefernces, matches are tailored towards their needs. For instance, if people declare that they have a disability, wanting to meet people without disabilities and interested in women. It will tailor matches for women who are open minded to meet people with disabilities to reduce the risks of rejections.

## Look View

The look view contains a list of matches where MatchSeekers can browse their potential matches using the list view.

## Profile View
The profile view contains information about a match seeker including their disability status, their screen name, profile picture, bio, favourite msuic and their interests. It will also contain if they are reported to be a scammer or if they have provided their backbground checks.

## Settings View
The settings view allows MatchSeekers to update their profile details, dating prerfences, upload background checks information and update their disability status.

### Privacy
If a Match Seeker declares that they have a disasbility, they can choose to disclose it on their profiles or hide it.

## DreamLists
The DreamList, also known as a favourites list is where match seekers can shortList their potential matches. This complys with one of the assignment requirements where the app can manage and edit tasks. For instance, a match seeker can add items onto the ddreamList and remove items from the DreamList.

# Code Structure

## Protocol Oriented Approach
The MatchSeeker struct confines with a Protocol Person because there is also an admin struct that needs to comform to the persons protocol.

### Verifiable Protocol
The Verifiable protocol is a protocol that is used to handle multple types of background checks including ProofOfAge, Police Checks and Raferee Checks. All of these checks have the same atrributes including Date Issued and Expiry dates that needs to conform to that protocol.


