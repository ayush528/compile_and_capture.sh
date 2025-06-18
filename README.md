# Java Code Screenshot Automation

This Bash script automates the process of compiling, running, and capturing screenshots of multiple Java programs defined in a single `codes.txt` file. It extracts Java code blocks, identifies the correct class name for each block, runs them in a terminal, and saves a screenshot of the output.

## 📁 Folder Structure

project-folder/
├── codes.txt # Input file with numbered Java programs
├── script.sh # The Bash script (name it anything, e.g., run_java_screenshots.sh)
├── screenshots/ # Folder where screenshots will be saved


## ✅ Features

- Parses multiple Java code blocks from a single `codes.txt` file.
- Detects the correct class name for each Java block (using `public class ClassName`).
- Compiles and runs each Java program in a new MATE terminal.
- Captures screenshots using `scrot` and saves them in the `screenshots/` folder.
- Cleans up `.java` and `.class` files after each run.
- Deletes any remaining `.class` files at the end.

## 🔧 Requirements

Ensure the following tools are installed on your system:

- `javac` and `java` (Java Development Kit)
- `mate-terminal` (comes with MATE Desktop Environment or install via package manager)
- `scrot` (used to take screenshots)
- Bash shell (default in most Linux systems)

## 📝 Input Format (`codes.txt`)

Each Java code block should start with a line number and a period (`1.`, `2.`, etc.). For example:

    public class HelloWorld {
    public static void main(String[] args) {
    System.out.println("Hello from Code 1");
    }
    }

    public class Greet {
    public static void main(String[] args) {
    System.out.println("Hello from Code 2");
    }
    }


> Note: The script uses the class name after `public class` as the filename. Make sure only one `public class` exists per code block.

## 🚀 How to Use

1. Place all your Java programs in `codes.txt` following the format above.
2. Make the script executable:

bash
chmod +x run_java_screenshots.sh

    Run the script:

./run_java_screenshots.sh

    After execution, check the screenshots/ directory for .png images of each program's output.

## ⚠️ Notes

    Each Java program must contain a public class definition.

    All terminal windows will require you to press Enter to close them.

    .class files will be deleted automatically after execution.

## 📷 Screenshot Output Example

Each image is named after the class it executed, like:

screenshots/HelloWorld.png
screenshots/Greet.png

