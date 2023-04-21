#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Define directories to exclude
exclude_dirs=(
  "node_modules"
  "build"
  "dist"
  "public"
)

# Initialize counters for updated files and ignored files
updated_count=0
ignored_count=0

# Initialize an array to keep track of ignored files
ignored_files=()

# Loop through all files in the current directory and subdirectories
while IFS= read -r file; do

  # Check if the file is empty
  if [ ! -s "$file" ]; then
    # Add the file to the ignored files array and increment the counter
    ignored_files+=("$file")
    ignored_count=$((ignored_count+1))
    continue
  fi

  # Check if the file already has a comment at the top
  if ! head -n1 "$file" | grep -q "path: "; then

    # Check if the file is in an excluded directory
    exclude=0
    for dir in "${exclude_dirs[@]}"; do
      if [[ "$file" =~ "$dir" ]]; then
        exclude=1
        break
      fi
    done
    if [ $exclude -eq 1 ]; then
      continue
    fi

    # Get the relative path of the file
    relative_path="${file#$current_dir/}"

    # Add a comment to the top of the file with the relative path
    if [[ "$file" == *".html" ]]; then
      sed -i "1s;^;<!-- path: $relative_path -->\n;" "$file"
    else
      sed -i "1s;^;// path: $relative_path\n;" "$file"
    fi

    # Increment the count of updated files
    updated_count=$((updated_count+1))

    # Print the name of the file that was updated
    echo "updated: $file"
  fi

done < <(find "$current_dir" -type f \( -name "*.jsx" -o -name "*.tsx" -o -name "*.js" -o -name "*.css" -o -name "*.scss" -o -name "*.html" \) ! -path "*/node_modules/*")

# Check if any files were updated and print a message accordingly
if [ $updated_count -eq 0 ]; then
  echo "No files have been updated."
else
  echo "$updated_count files have been updated."
fi

# Check if any files were ignored and print a message and list of ignored files
if [ $ignored_count -gt 0 ]; then
  echo "$ignored_count empty file(s) were ignored:"
  for ignored_file in "${ignored_files[@]}"; do
    echo "$ignored_file"
  done
fi

# Close the terminal window
exit
