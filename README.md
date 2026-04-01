# VoidVault

VoidVault is a Flutter-based cloud gallery app that overcomes storage limitations by distributing image uploads across multiple Cloudinary accounts using an automatic failover mechanism.

---

## Features

* Multi-account Cloudinary integration
* Automatic failover upload system
* Unified gallery view
* Fullscreen image viewer
* Image caching for performance

---

## Tech Stack

* Flutter
* Riverpod
* Firebase Authentication and Firestore
* Cloudinary API

---

## Core Concept

```text
Upload → Try Account A → Fail → Try Account B → Success
```

---

[Your Name]
