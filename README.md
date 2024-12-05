# GeoStats.jl @ FOSS4G 2024

Instructor: [Júlio Hoffimann](https://juliohm.github.io)

## Preview

Interactive 3D visualization of interpolated temperature from meteorological stations in Brazil:

![preview](https://i.imgur.com/5t1txH7.png)

## Installation

*We highly recommend installing the software before the workshop.*

### 1. Julia language

Please go to https://julialang.org/downloads and install
**Julia v1.11** via **juliaup**. If you are on Windows,
search for "julia" in the app store, it has the same effect.

Launch Julia by clicking on the Julia icon on the menu bar or
by typing "julia" in your terminal. Both methods should work.

### 2. VSCode IDE

Please go to https://code.visualstudio.com and install Visual
Studio Code. We will use VSCode to write scripts, inspect results,
etc.

### 3. Julia extension for VSCode

Launch VSCode, and click on the `Extensions` tab on the left bar
(or press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>X</kbd>). Search
for "julia" and install the extension.

Start Julia within VSCode to make sure that the extension was
installed correctly. You can do that by pressing
<kbd>Alt</kbd>+<kbd>J</kbd> <kbd>Alt</kbd>+<kbd>O</kbd>.

### 4. Project files and environment

Download the ZIP archive with all project files by pressing on
the green `Code` button above, and on the `Download ZIP` button.
Unzip the files in a local directory that you can easily find later.

Open the project folder on VSCode, start Julia in the folder, and instantiate the project environment:

```julia
# import package manager
import Pkg

# activate current folder
Pkg.activate(".")

# download/precompile packages
Pkg.instantiate()
```

The instantiation may take a couple of minutes depending on your
internet connection and hardware.

## Answers

The final script with all answers can be found in the `answers` branch of this repository.
