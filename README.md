# 🛑 QB-AntiDump

A lightweight, high-performance security script designed exclusively for the **QBCore Framework**. Protect your custom assets, proprietary mechanics, and server configurations from unauthorized runtime dumping, client-side memory extraction, and asset leaks. 

---

## 🧮 Features

* **Anti-Extraction Hooks:** Actively blocks standard execution injection points (`loadstring`, `RunString`, `ExecuteLua`) commonly exploited by private menus.
* **Cryptographic Integrity Shunt:** Uses a server-side file signature check (`GetHashKey`) on boot. If the resource files are tampered with or modified locally, it auto-terminates to prevent a compromised startup.
* **Environment Metatable Locking:** Enforces strict limitations on the global client environment state (`_G`). This blocks dumpers from crawling, reading, or mapping out core framework variables and server triggers.
* **Dynamic Containment:** Instantly drops players from the session the millisecond an internal environment breach or modification is detected.
* **Performance-First Design:** Fully optimized thread cycles running at **0.00ms CPU time** at rest, keeping your server metrics completely clean.

---

## 🧰 Requirements

* [FXServer](https://fivem.net/) (Linux or Windows)
* [QBCore Framework](https://github.com/qbcore-framework)
* *No external dependencies or SQL requirements.*

---

## 🚀 Installation

### 1. File Placement
Download and extract the repository contents into your server's resource directory under your preferred security category folder:
```text
resources/[security]/qb-antidump/
├── fxmanifest.lua
├── server.lua
└── client.lua
