# XJObsidian

XJObsidian is a tool that makes note-taking with xournal++ and Obsidian easier.

## Table of Contents
- [Roadmap](#roadmap)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Roadmap
View project's [Roadmap](./ROADMAP.md) and don't be shy to propose your changes in [issues](https://github.com/AstyCX/xjobsidian/issues)

## Features
- ### Xournal++ & Obsidian seamless note taking integration
  
  1. Simultaneously creates 3 files for your note: **.xopp** file with the note and its metadata, **pdf** with an "on save" update, and **.md** file with automatically embedded created pdf.
  2. Opens the created note in Xournal++ & Obsidian (.xopp in Xournal++ and .md in Obsidian)
  3. When you make changes in your note (.xopp) file - remember to save the edited note

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
- Provide absolute path to your **Vault**, **Xournal++ template** (that would be used by default to create new notes) and **path to a folder** inside of your Vault where you want to save new notes
- Path **must** be in a format of $HOME/...
- In order to change the configuration, navigate to ~/.xjobsidian_config

## Usage
```sh
xjobsidian <subfolder> <title>
```
Creates a note **<title>** in $HOME/<yourpath>/<notes_folder>/<subfolder>

If called without params, asks for the params in the terminal 
```sh
xjobsidian
```

## License
This project is licensed under the GNU General Public License v3.0. See the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.en.html) file for details.
