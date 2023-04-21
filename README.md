# Add Path Comments to Files Script

This Bash script automatically adds a comment to the top of all non-empty (empty will be ignored) JavaScript, CSS, HTML, and SCSS files in a directory and its subdirectories. The comment contains the relative path of the file from the root directory.

Example:

```
// path: src/components/Icon/Icon.jsx
```

This script is primarily designed for React and Node.js projects, but it should work for other JavaScript-based projects as well.

## Installation

1. Copy the contents of the `pathToFiles.sh` script to a new file in your scripts directory, for example `~/scripts/PathToFiles.sh`

2. Make the script executable with the following command:

```
chmod +x ~/scripts/pathToFiles.sh
```

3. Add your scripts directory to your PATH environment variable by adding the following line to your .bashrc file (in this example `~/scripts`):

```
export PATH="$HOME/scripts:$PATH"
```

4. Reload your Bash shell by running the following command:

```
 source ~/.bashrc
```

## Usage

To run the script, navigate to the directory you want to add path comments to and run the following command:

```
pathToFile.sh
```

**( If you have named your script differently, use the name of your script. )**

The script will then add a comment to the top of all non-empty JavaScript, CSS, HTML, and SCSS files in the directory and its subdirectories, excluding any files in the node_modules, build, dist, and public directories. It will also print a message indicating how many files were updated and how many empty files were ignored.

_Note that the script may not work on Windows without modification because Windows uses a different shell language. However, it should work on macOS and most Unix-like operating systems._
