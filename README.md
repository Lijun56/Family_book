## Introduction
Family book is a iOS app, made with ARkit supported by the Apple. Inspired by the "live newspaper" in the movie "Harry Potter". the photo in the newspaper is able to play a video and attached on the photo itself. With the vision of our phone, we are able to generate the function with AR. 
## Technologies
the iOS app has implement the `firebase`supported by the Google for manage user data and authtification, `ARKit`, supported by the Apple, for the technical support of AR effect.

## How to use
Basically, as the user chooses a photo as the target photo and video as the video should to be played. When the photo get detected the AR environment would generate a plane modle on it abd track the plane when the camera get moved, next the video would automatically be attached on the plane and be played, and in the meanwhile, the camera will keep tracking the plane model
1. In the main page, click`Register`to register a account for the app. `Login`allow the user to log in with the username and password that be registered before. Both register and login take the user to the AR page.
2. In the upper-right cornor ,clicking `+` can take user to its photo library to pick the photo and video. the user are expected to choose the photo first and the video latter. After, we click `add` for implementation, the click the `ARupupup!!!` in the middle of the page. it can take you to the camera page(if u do have a camera(doge))
3. As camera detect the photo u chose(make sure the photo is printed or the display on another screen), it will display the video u chose
