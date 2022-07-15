# Pre-work - tip-calculator

tip-calculator is a tip calculator application for iOS.

Submitted by: Nick Melkadze

Time spent: **16** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly

The following **optional** features are implemented:

* [X] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Currency choices
- [X] Light and dark (and auto) modes
- [X] Slider control
- [X] Settings page
- [X] About page
- [X] Custom app icon
- [X] Decimal keyboard
- [X] Settings persistence (saved in UserDefaults)
- [X] Party splitting

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/FY0l9AS.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' /> 

## Notes

While building the app, one of the challenges I encountered was getting the light/dark mode to apply to all views.
I wanted to specifically use the "Show Detail" segue instead of the "Show" segue for my settings and options pages (which pop up from the top while keeping the original view partially visible) as they would make the app feel more cohesive, but this made it so that viewWillAppear did not trigger when returning to the main view.
I spent a lot of time reading documentation in an effort to resolve this, and was able to get it to work by manually triggering the viewWillAppear property of the main view from the settings view (as this is the one which allows changing light/dark mode) by using the presentingViewController property.

Another challenge I encountered revolves around the fact that my vision was to have an option to use a slider to control the tip amount, in addition to the default segmented view. My idea was to be able to change which was used in the settings, so that users who require more than the default three options can use that more advanced interface, while those who didn't need it could use the simpler three-button layout.
In order to maintain visual consistency, I wanted to display both of these potential control methods in the same location, however, I was unsure how to do this well. I had considered programming the elements of either view to move beyond the bounds of the view (and thus not be seen) when they are not needed, but was able to come up with a much better solution: placing both sets of controls on top of each other in the Storyboard, and simply setting the .isHidden property on whichever elements were unneeded at that time.

A final, less programming-related challenge was setting up the app to run on my own phone. I was able to test the app on Xcode's simulator, but I thought it would be interesting to demo it on actual hardware. This involved a lot of setup with trusting my developer ID on my phone, setting up signing certificates, and even creating a custom icon.
In the end, I was able to install the app on my phone, and now (in addition to recording the demo on actual hardware), I can always make use of my app whenever I need to figure out how much to tip!

## License

    Copyright [2022] [Nick Melkadze]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
