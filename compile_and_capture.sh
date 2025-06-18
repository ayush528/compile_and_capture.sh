#!/bin/bash

# Directory to store screenshots
SCREENSHOT_DIR="screenshots"
mkdir -p "$SCREENSHOT_DIR"

# File containing Java codes
JAVA_CODES_FILE="codes.txt"

echo "Using file: $JAVA_CODES_FILE"

# Extract Java codes and loop through them
counter=1
java_code=""

# Function to compile and run Java code
compile_and_run() {
  local code_number="$1"
  local code_content="$2"
  
  # Extract the class name using grep
  local class_name=$(echo "$code_content" | grep -oP 'public class \K\w+')
  
  # Check if a class name was found
  if [ -z "$class_name" ]; then
    echo "No public class found in code block $code_number."
    return
  fi

  java_filename="${class_name}.java"
  echo "Creating file: $java_filename"
  echo "$code_content" > "$java_filename"

  # Compile the Java code
  echo "Compiling $java_filename..."
  javac "$java_filename"
  if [ $? -eq 0 ]; then
    echo "Compilation successful for $java_filename."
    
    # Run the compiled code in a new MATE terminal
    mate-terminal -- bash -c "java $class_name; echo 'Press Enter to close...'; read"
    
    # Take a screenshot of the output (screenshot after a delay)
    sleep 2  # Wait for the output to show up
    screenshot_file="$SCREENSHOT_DIR/${class_name}.png"
    scrot "$screenshot_file"
    echo "Screenshot saved: $screenshot_file"
  else
    echo "Compilation error in code block $code_number"
  fi

  # Clean up individual class files
  rm "$java_filename" "${class_name}.class"
}

# Read the file line by line
while IFS= read -r line || [ -n "$line" ]; do
  if [[ "$line" =~ ^[[:space:]]*[0-9]+\..* ]]; then
    # If it's a numbered line, save the previous block and start a new one
    if [ -n "$java_code" ]; then
      compile_and_run "$counter" "$java_code"
      ((counter++))
      java_code=""
    fi
  fi
  # Append the line to the current Java code block, excluding the number
  java_code+="${line#*[0-9]. }"$'\n'
done < "$JAVA_CODES_FILE"

# Save and compile the last block if any
if [ -n "$java_code" ]; then
  compile_and_run "$counter" "$java_code"
fi

# Cleanup: Remove all .class files
echo "Cleaning up..."
rm *.class
echo "All codes processed."

