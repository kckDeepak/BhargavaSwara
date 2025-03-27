# BhargavaSwara

**A Flutter Application for Indian Classical Music Analysis & Synthesis**

BhargavaSwara is a cross-platform Flutter application that integrates the [BhargavaSwara Library](https://github.com/Shouryaanga-Tribe/BhargavaSwaraLibrary) to provide an intuitive interface for analyzing and synthesizing Indian Classical Music. Designed for musicians, researchers, and enthusiasts, this app leverages advanced signal processing and machine learning techniques to explore the rich traditions of Indian music.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Languages](https://img.shields.io/github/languages/count/Shouryaanga-Tribe/BhargavaSwara)](https://github.com/Shouryaanga-Tribe/BhargavaSwara)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Google Tools Used](#google-tools-used)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

---

## Overview

BhargavaSwara combines a modern Flutter-based frontend with the powerful BhargavaSwara Library, offering a seamless experience for Indian Classical Music analysis and synthesis. From real-time raga identification to generating tanpura drones, this app bridges tradition and technology with a user-friendly design.

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

## Technologies Used

- **Flutter:** Cross-platform UI framework for Android, iOS, and more.
- **Dart:** Language for app logic and UI development.
- **BhargavaSwara Library:** Core audio processing and analysis (C++ backend).
- **CMake:** Build system for native components.
- **Swift:** Native iOS/macOS integration (optional).

---

## Google Tools Used

BhargavaSwara leverages several Google tools to enhance development, testing, and machine learning capabilities:

- **Google Colab:**  
  A cloud-based Jupyter notebook environment used for prototyping and testing audio analysis algorithms. Colab provided an accessible platform for experimenting with signal processing techniques and integrating them with the BhargavaSwara Library.

- **Project IDX:**  
  Google’s Project IDX, an integrated development environment (IDE), was utilized to streamline the development workflow. It enabled rapid prototyping of the Flutter frontend and seamless integration with native C++ components. Project IDX’s cloud-based features also facilitated collaborative coding and testing across different devices and platforms.

- **Gemini APIs:**  
  The Gemini APIs, part of Google’s generative AI suite, were employed to enhance music analysis and synthesis. These APIs powered advanced machine learning models for raga and ornamentation detection, leveraging their natural language and pattern recognition capabilities to interpret complex musical structures. The APIs were integrated into the app for real-time processing and to support the generation of synthesized musical elements like tanpura drones.

- **TensorFlow:**  
  TensorFlow, Google’s open-source machine learning framework, was used in conjunction with Colab to train and fine-tune models for audio feature extraction (e.g., MFCCs and spectrograms). These models were later optimized for deployment within the BhargavaSwara Library, ensuring efficient performance on mobile devices.

---

## Repository Structure

```
BhargavaSwara/
├── .vscode/                   # VSCode settings and configurations
├── lib/                       # Flutter source code
│   ├── screens/              # UI screens for analysis and synthesis
│   ├── widgets/              # Reusable UI components
│   └── services/             # BhargavaSwara Library integration
├── assets/                    # Sample audio files and images
├── native/                    # Native C++ and Swift code
├── README.md                  # Project documentation
└── LICENSE                    # MIT License file
```

- **lib:** Core Flutter code, organized into screens, widgets, and services.
- **assets:** Resources for testing and demonstration.
- **native:** Native code linking to the BhargavaSwara Library.

---

## Installation

### Prerequisites
- **Flutter SDK:** Download from [flutter.dev](https://flutter.dev/docs/get-started/install).
- **Dart:** Included with Flutter.
- **BhargavaSwara Library:** Must be installed and linked (see [BhargavaSwara Library repo](https://github.com/Shouryaanga-Tribe/BhargavaSwaraLibrary)).
- **C++ Compiler:** Supports C++11 or later.
- **CMake:** For building native code.

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

*Note: Check code comments for additional setup instructions.*

---

## Usage

BhargavaSwara offers an interactive platform for music analysis and synthesis:

- **Analyzing Music:**  
  - Use the microphone or upload audio files.  
  - View real-time raga, tala, and tempo analysis.  
  - Explore spectrograms within the app.

- **Synthesizing Music:**  
  - Generate tanpura drones or instrument sounds.  
  - Create and customize tala patterns.

Sample assets are included in the `assets` directory for testing.

---

## Contributing

We welcome contributions! To contribute:

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

5. **Submit a Pull Request:** Provide a detailed description.

Adhere to coding standards and include tests where applicable.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

- **Email:** [kckdeepak29@gmail.com](mailto:kckdeepak29@gmail.com)  
- **GitHub Issues:** [BhargavaSwara Issues](https://github.com/Shouryaanga-Tribe/BhargavaSwara/issues)

---

## Acknowledgments

- The Indian Classical Music community for their inspiration.
- BhargavaSwara Library team for their foundational work.
- Contributors and testers for their valuable feedback.

---
