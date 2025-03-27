# BhargavaSwara

**A Flutter Application for Indian Classical Music Analysis & Synthesis**

BhargavaSwara is a cross-platform Flutter application showcasing the capabilities of the [BhargavaSwara](https://github.com/Shouryaanga-Tribe/BhargavaSwaraLibrary) library. Designed for musicians, researchers, and enthusiasts, this app provides an intuitive interface to analyze and synthesize Indian Classical Music using advanced signal processing and machine learning techniques.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Languages](https://img.shields.io/github/languages/count/Shouryaanga-Tribe/BhargavaSwara)](https://github.com/Shouryaanga-Tribe/BhargavaSwara)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

---

## Overview

BhargavaSwara Demo integrates the BhargavaSwara library into a modern Flutter-based frontend, offering a seamless way to explore Indian Classical Music analysis and synthesis. Whether you're identifying ragas in real-time or generating tanpura drones for practice, this app combines a user-friendly design with powerful backend functionality.

---

## Features

### Music Analysis
- **Raga Recognition:** Detect and classify ragas from audio input.
- **Tala Recognition:** Identify rhythmic cycles (talas) in performances.
- **Tempo Detection:** Calculate the tempo of musical pieces.
- **Ornamentation Detection:** Recognize and categorize musical embellishments.
- **Hindustani/Carnatic Identifier:** Differentiate between music traditions.
- **Real-Time Analysis:** Analyze live audio streams instantly.
- **Spectrogram Visualizations:** Display MFCC, Mel spectrograms, and signal graphs.

### Music Synthesis
- **Instrument Imitation:** Replicate traditional instrument sounds.
- **Tanpura Drone Generation:** Create harmonic tanpura drones.
- **Tala Generation:** Generate rhythmic patterns for practice.

---
## Google Tools Used
- **Google Colab:**
project idx, tensorflow, geminiapis
## Technologies Used

- **Flutter:** Cross-platform UI framework for Android, iOS, and more.
- **Dart:** Language for app logic and UI development.
- **BhargavaSwara Library:** Core audio processing and analysis (C++ backend).
- **CMake:** Build system for native components.
- **Swift:** Native iOS/macOS integration (optional).

---

## Installation

### Prerequisites
- **Flutter SDK:** Download from [flutter.dev](https://flutter.dev/docs/get-started/install).
- **Dart:** Included with Flutter.
- **BhargavaSwara Library:** Must be installed and linked (see [BhargavaSwara repo](https://github.com/Shouryaanga-Tribe/BhargavaSwara)).


### Setup Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Shouryaanga-Tribe/BhargavaSwara.git
   cd BhargavaSwara
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Build Native Components**
   ```bash
   cd native
   mkdir build && cd build
   cmake ..
   make
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

*Note: Refer to code comments for additional setup details.*

---

## Usage

BhargavaSwara Demo offers an interactive experience for music analysis and synthesis:

- **Analyzing Music:**  
  - Use the microphone or upload audio files.  
  - View real-time raga, tala, and tempo analysis.  
  - Explore spectrograms in the app.

- **Synthesizing Music:**  
  - Generate tanpura drones or instrument sounds.  
  - Create and customize tala patterns.

Sample assets are included in the `assets` directory for testing.

---

## Contributing

Contributions are encouraged! To contribute:

1. **Fork the Repository**
   ```bash
   git clone https://github.com/Shouryaanga-Tribe/BhargavaSwara.git
   cd BhargavaSwara
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Commit Changes**
   ```bash
   git commit -m "Describe your changes"
   ```

4. **Push to GitHub**
   ```bash
   git push origin feature/YourFeatureName
   ```

5. **Submit a Pull Request:** Include a detailed description.

Follow coding standards and add tests where possible.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

- **Email:** [kckdeepak29@gmail.com](mailto:kckdeepak29@gmail.com)  
- **GitHub Issues:** [BhargavaSwara Issues](https://github.com/Shouryaanga-Tribe/BhargavaSwara/issues)

---

## Acknowledgments

- The Indian Classical Music community for inspiration.
- BhargavaSwara library team for their foundational work.
- Contributors and testers for their valuable input.

---
```

This version ensures consistent formatting, clear headings, and a professional tone, tailored to the Flutter frontend demo for the BhargavaSwara library. Let me know if you need further tweaks!