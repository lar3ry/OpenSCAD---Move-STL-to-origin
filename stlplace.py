import math
import stl
from stl import mesh
import numpy

import os
import sys

if len(sys.argv) < 2:
    sys.exit('Usage: %s [stl file]' % sys.argv[0])

if not os.path.exists(sys.argv[1]):
    sys.exit('ERROR: file %s was not found!' % sys.argv[1])

# this stolen from numpy-stl documentation
# https://pypi.python.org/pypi/numpy-stl

# find the max dimensions, so we can know the bounding box, getting the height,
# width, length (because these are the step size)...
def find_mins_maxs(obj):
    minx = maxx = miny = maxy = minz = maxz = None
    for p in obj.points:
        # p contains (x, y, z)
        if minx is None:
            minx = p[stl.Dimension.X]
            maxx = p[stl.Dimension.X]
            miny = p[stl.Dimension.Y]
            maxy = p[stl.Dimension.Y]
            minz = p[stl.Dimension.Z]
            maxz = p[stl.Dimension.Z]
        else:
            maxx = max(p[stl.Dimension.X], maxx)
            minx = min(p[stl.Dimension.X], minx)
            maxy = max(p[stl.Dimension.Y], maxy)
            miny = min(p[stl.Dimension.Y], miny)
            maxz = max(p[stl.Dimension.Z], maxz)
            minz = min(p[stl.Dimension.Z], minz)
    return minx, maxx, miny, maxy, minz, maxz

main_body = mesh.Mesh.from_file(sys.argv[1])

minx, maxx, miny, maxy, minz, maxz = find_mins_maxs(main_body)

minx=round(minx,3)
maxx=round(maxx,3)
miny=round(miny,3)
maxy=round(maxy,3)
minz=round(minz,3)
maxz=round(maxz,3)

xsize = round(maxx-minx,3)
ysize = round(maxy-miny,3)
zsize = round(maxz-minz,3)

midx = round(xsize/2,3)
midy = round(ysize/2,3)
midz = round(zsize/2,3)

ctrx = round(-minx+(-midx),4)
ctry = round(-miny+(-midy),4)
ctrz = round(-minz+(-midz),4)

# the logic is easy from there

print("")
print ("// File:", sys.argv[1])
lst = ['obj =("',sys.argv[1],'");']
obj = ['\t\timport("',sys.argv[1],'");']

print ("// X size:",xsize)
print ("// Y size:", ysize)
print ("// Z size:", zsize)
print ("// X position:",minx)
print ("// Y position:",miny)
print ("// Z position:",minz)

#--------------------

print("")
print("Positions: NE, NW, SW, SE, Centre XY, Centre All")

print("")
print ("// NE")
print("translate([",-minx,",",-miny,",",-minz,"])")
print (' import ("',sys.argv[1],'");',sep='')

print("")
print ("// NW")
print("translate([",-minx + (-xsize),",",-miny,",",-minz,"])")
print (' import ("',sys.argv[1],'");',sep='')

print("")
print ("// SW")
print("translate([",-minx + (-xsize),",",-miny +(-ysize),",",-minz,"])")
print (' import ("',sys.argv[1],'");',sep='')

print("")
print ("// SE")
print("translate([",-minx,",",-miny+(-ysize),",",-minz,",","])")
print (' import ("',sys.argv[1],'");',sep='')

print ("")
ctrx = round(-minx+(-midx),4)
ctry = round(-miny+(-midy))
ctrz = round(-minz+(-midz))

print ("// Center XY")
print("translate([",ctrx, ",",ctry,",",-minz,"])")
print (' import ("',sys.argv[1],'");',sep='')

print ("")
print ("// Centre All")
print("translate([",ctrx, ",",ctry,",",ctrz,"])")
print (' import ("',sys.argv[1],'");',sep='')
print ("")
