# xjobsidian

xjobsidian is a tool that makes note-taking with xournal++ and Obsidian easier.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features
- Xournal++ & Obsidian seamless note taking integration
- Easy setup and installation
- Enhances productivity and note-taking efficiency

## Installation

### Prerequisites
- Git
- Bash

### Steps
1. Clone the repository:
```sh
git clone https://github.com/AstyCX/xjobsidian.git
```
2. Navigate into the directory:
```sh
cd xjobsidian
```
3. Make the script executable and run it:
```sh
chmod +x install.sh
./install.sh
```
4. Setting up the configuration
- Provide absolute path to your Vault, Xournal++ template and folder inside of the Vault where you want to save new notes
- Path **must** be in a format of $HOME/...
- In order to change the configuration, navigate to ~/.xjobsidian_config

## Usage
```sh
xjobsidian <folder> <title>
```
Creates a note **<title>** in $HOME/<yourpath>/<notes_folder>/<folder>

If called without params, asks for the params in the terminal 
```sh
xjobsidian
```

## License
This project is licensed under the GNU General Public License v3.0. See the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.en.html) file for details.
