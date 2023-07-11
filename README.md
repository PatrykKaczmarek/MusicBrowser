# MusicBrowser 🎶

## Authors

* Patryk Kaczmarek
	* [Github](https://github.com/PatrykKaczmarek)
	* [LinkedIn](https://www.linkedin.com/in/patryk-kaczmarek-ios/)

## Tools & Services

* Tools:
  * [Xcode 14.3](https://developer.apple.com/download/) with latest iOS SDK

## Project Setup

### Instalation

1. Clone repository:

  ```bash
  # over https:
  https://github.com/PatrykKaczmarek/MusicBrowser.git
  # or over SSH:
  git@github.com:PatrykKaczmarek/MusicBrowser.git
  ```

2. Open `MusicBrowser.xcodeproj` file and build the project.

## Coding guidelines

- Respect Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- The code must be readable and self-explanatory - full variable names, meaningful methods, etc.
- Don't leave any commented-out code.

## About the project

The application isn't rocket science, and that's intentional. It has been created with an assumption that there is still some part of code using Objective-C. This implementation is encapsulated, so it doesn't leak outside to the newer parts of the app. 

**Requirements**:

- Implementation consists of two languages: `Objective-C` and `Swift`. This is intentional to show interoperability.
- UI is written mainly in `UIKit` with a small usage of `SwiftUI`.
- The application allows the user to add albums to favorites and store this information persistently on the device.
- User Interface design:
	- is pretty simple.
	- playlists should scroll vertically.
	- albums added to a playlist should scroll horizontally.
- API:
	- contains some minor issues. The app handles them gracefully. 

## Credentials

### API

- [Mocky](https://designer.mocky.io)
