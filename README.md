# OpenSCAD---Move-STL-to-origin
Makes a library tailored to an existing STL file. Move it to the origin in OpenSCAD.

Uses a modified version of a Python script, `stldim.py`, by Jamie Bainbridge. His version can be found at:
  https://www.reddit.com/r/3Dprinting/comments/7ehlfc/python_script_to_find_stl_dimensions/

I often edit STL files to customize, improve, or repair them, and I find that sometimes the object is placed well away from the OpenSCAD origin, and I have to guess at what translation to use to put it at the origin, then fiddle with the translation to fine tune the position. This program will place the object in one of 5 different places, each one touching the origin (where the x, y and z axes meet). You have the choice of placing it in the center or adjacent to the origin, determined by compass directions, NE, NW, SW, SE.

The modified python script, `stldim.py` (included here), when run in the directory of a file you want to place, will generate a file that may be used as a library. It will contain, as well as the code to place the object, comments showing the max and min x, y, and z values (a bounding box), as well as the x, y, and z size of the object (handy for woodworkers laying out cuts for lumber or plywood).

It may be used stand-alone, or as a library.

## Prerequisites

You will have to install `stl`, `numpy`, and `numpy-stl` Python packages in case you don't have those already.

    pip install stl
    pip install numpy
    pip3 install numpy-stl

Thanks to **Carsten Arnholm** for pointing these out to me.

## Usage

Place the `stldim.py` file where you keep your Python executable scripts. Its usage is like this:

```
./stldim.py [stl file]                # prints the result in stdout
./stldim.py [stl file] > [scad file]  # writes the result into a .scad file
```

On a command line, CD to the directory containing the STL you wish to move, and run the script, giving it the name of the STL file as an argument. If you wish, you can redirect the output to a library file as well (see the example below).

## Example

To use the example, place `Hook.stl` and `Hook.SCAD` in the same directory. Using the command line, CD to the directory and run the python script as follows:

```
./stldim.py Hook.stl > Hook_2origin.scad
```

Load the `Hook.scad` file.
Previewing `Hook.scad` will show the object in the NE position.
Putting an exclamation mark before any one of the `obj2origin(xx);` lines will just display one of the results.

## Running in Docker

In case you prefer to run the script inside a [Docker](https://docs.docker.com/install/) container, a helper script is provided for that. By using that you don't need to install any Python dependencies on your host OS. The commands are:

```
./run-in-docker.sh [stl file]              # prints the result in stdout
./run-in-docker.sh [stl file] [scad file]  # writes the result into a .scad file
```

Because the output includes also the output from the Docker build process, normal *nix piping operators will not work here as desired, and thus `>` is missing from the latter line.
