<div align="left">
  
  <div align="center">
    <h1>i2hand</h1>

  <p>
This is a re-commerce application for user who want to buy second-hand electronic
  </p>
  </div>
  
  
<!-- Badges -->

<br />
  <div align ="center">
    <p>
      <a href="https://github.com/dustin-goldenowl/safebump/graphs/contributors">
        <img src="https://img.shields.io/github/contributors/dustin-goldenowl/safebump" alt="contributors" />
      </a>
      <a href="">
        <img src="https://img.shields.io/github/last-commit/dustin-goldenowl/safebump" alt="last update" />
      </a>
      <a href="https://github.com/dustin-goldenowl/safebump/network/members">
        <img src="https://img.shields.io/github/forks/dustin-goldenowl/safebump" alt="forks" />
      </a>
      <a href="https://github.com/dustin-goldenowl/safebump/stargazers">
        <img src="https://img.shields.io/github/stars/dustin-goldenowl/safebump" alt="stars" />
      </a>
      <a href="https://github.com/dustin-goldenowl/safebump/issues/">
        <img src="https://img.shields.io/github/issues/dustin-goldenowl/safebump" alt="open issues" />
      </a>
      <a href="https://github.com/dustin-goldenowl/safebump/blob/master/LICENSE">
        <img src="https://img.shields.io/github/license/dustin-goldenowl/safebump.svg" alt="license" />
      </a>
    </p>
      
  <h4>
      <a href="https://github.com/dustin-goldenowl/jobspot/">View Demo</a>
    <span> · </span>
      <a href="https://github.com/dustin-goldenowl/jobspot">Documentation</a>
    <span> · </span>
      <a href="https://github.com/dustin-goldenowl/jobspot/issues/">Report Bug</a>
    <span> · </span>
      <a href="https://github.com/dustin-goldenowl/jobspot/issues/">Request Feature</a>
    </h4>
  </div>
  </div>
<br />

<!-- Table of Contents -->
# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)
  * [Screenshots](#camera-screenshots)
  * [Tech Stack](#space_invader-tech-stack)
  * [Features](#dart-features)
  * [Color Reference](#art-color-reference)
  * [Environment Variables](#key-environment-variables)
- [Getting Started](#toolbox-getting-started)
  * [Prerequisites](#bangbang-prerequisites)
  * [Installation](#gear-installation)
  * [Running Tests](#test_tube-running-tests)
  * [Run Locally](#running-run-locally)
  * [Deployment](#triangular_flag_on_post-deployment)
- [Usage](#eyes-usage)
- [Roadmap](#compass-roadmap)
- [Contributing](#wave-contributing)
  * [Code of Conduct](#scroll-code-of-conduct)
- [FAQ](#grey_question-faq)
- [License](#warning-license)
- [Contact](#handshake-contact)
- [Acknowledgements](#gem-acknowledgements)

<!-- About the Project -->
## :star2: About the Project <a name="star2-about-the-project"></a>

<!-- Screenshots -->
### :camera: Screenshots <a name="camera-screenshots"></a>

COMING SOON

<!-- TechStack -->
### :space_invader: Tech Stack <a name="space_invader-tech-stack"></a>

<details>
  <summary>Mobile</summary>
  <ul>
    <li><a href="https://dart.dev/">Dart</a></li>
    <li><a href="https://flutter.dev/">Flutter</a></li>
  </ul>
</details>

<details>
  <summary>Serverless</summary>
  <ul>
    <li><a href="https://console.firebase.google.com/">Firebase</a></li>
  </ul>
</details>

<details>
<summary>Local Database</summary>
  <ul>
    <li><a href="https://drift.simonbinder.eu/">Drift - Sqlite3</a></li>
  </ul>
</details>
<details>

<summary>DevOps</summary>
  <ul>
    <li><a href="https://www.gtihub.com/">Github</a></li>
    <li><a href="https://www.gtihub.com/">Github ACtion</a></li>
    <li><a href="https://fastlane.tools/">Fastlane</a></li>
    <li><a href="https://firebase.google.com/docs/crashlytics/">Firebase Crashlytics</a></li>
  </ul>
</details>

<!-- Features -->
### :dart: Features

User
- Sign In, Sign Up
- Forgot Password
- eKYC
- Create product post, up load image and description
- Review product
- Payment
- Manage user's product
- Search product
- Manage notifications

Admin
- Sign In
- Approve eKYC
- Approve product post
- Create and manage list categories

<!-- Color Reference -->
### :art: Color Reference

COMING SOON

<!-- Env Variables -->
### :key: Environment Variables

Coming soon

<!-- To run this project, you will need to add the following environment variables to your .env file

`API_KEY`

`ANOTHER_API_KEY` -->

<!-- Getting Started -->
## 	:toolbox: Getting Started

<!-- Prerequisites -->
### :bangbang: Prerequisites

This project uses Fastlane to auto deploy Firebase Distribution. You need to install Fastlane for this project. You need to install the ruby environment before installing Fastlane. Download and install [here](https://rubygems.org)

After installation is complete, run the command below to install Fastlane

```bash
 gem install fastlane
```

<!-- Installation -->
### :gear: Installation

Install all package in project

```bash
  flutter pub get
```
   
<!-- Running Tests -->
### :test_tube: Running Tests

To run tests, run the following command

```bash
  flutter test test/widget_test.dart
```

<!-- Run Locally -->
### :running: Run Locally

Clone the project

```bash
  git clone https://github.com/dustin-goldenowl/i2hand.git
```

Install dependencies

```bash
  flutter pub get
```

Set up Multiple Language

```bash
  flutter gen-l10n
```

Start the project

```bash
  flutter run
```


<!-- Deployment -->
### :triangular_flag_on_post: Deployment

To deploy this project to Firebase Distribution

```bash
  fastlane deploy_firebase_distribution version_name: version_name version_code: version_code
```

To deploy this project to CH Play

```bash
  fastlane deploy_ch_play version_name: version_name version_code: version_code
```

<!-- Directory structure -->
## :eyes: Directory Structure
COMING SOON

<!-- Architecture Diagram -->
## :chart: Architecture Diagram

<a href="https://edrawcloudpublicus.s3.amazonaws.com/viewer/self/4887705/share/2024-1-31/1706672623/main.svg">
  <img src="https://edrawcloudpublicus.s3.amazonaws.com/viewer/self/4887705/share/2024-1-31/1706672623/main.svg">
</a>

<!-- Database Diagram -->
## :chart: Database Diagram

COMING SOON

<!-- Contributing -->
## :wave: Contributing

<a href="https://github.com/dustin-goldenowl/safebump/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=dustin-goldenowl/safebump" />
</a>

Contributions are always welcome!
See `contributing.md` for ways to get started.

<!-- FAQ -->
## :grey_question: FAQ

Coming soon

<!-- License -->
## :warning: License

Distributed under the no License. See ```LICENSE``` for more information.


<!-- Contact -->
## :handshake: Contact

Lance Dinh - [@DeathA2](https://www.facebook.com/DeathA2/) - lance.dinh.goldenowl@gmail.com

Project Link: [https://github.com/dustin-goldenowl/i2hand](https://github.com/dustin-goldenowl/i2hand)


<!-- Acknowledgments -->
## :gem: Acknowledgements
In i2hand project, I used some useful resources and libraries to aid the development process.

 - [Desgin Figma](https://www.figma.com/file/2sMOWSroKFDsthE6Nn10ov/Job-Finder-Ui-App-Kit-(Community)?type=design&node-id=0%3A1&mode=design&t=yOVRg0VfUB2TVE5I-1)
 - [Firebase and related packages](https://firebase.google.com/)
 - [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
 - [Auto Route](https://pub.dev/packages/auto_route)
 - [GetIt](https://pub.dev/packages/get_it)
 - [Flutter SVG](https://pub.dev/packages/flutter_svg)
 - [Shared Preferences](https://pub.dev/packages/shared_preferences)
 - [Drift](https://pub.dev/packages/drift)
