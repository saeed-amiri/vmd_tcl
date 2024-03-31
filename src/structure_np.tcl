# Get the number of representations
set numreps [molinfo top get numreps]

# Delete all representations
for {set i 0} {$i < $numreps} {incr i} {
    mol delrep 0 top
}

# Selecting water molecules
mol addrep top
mol modselect 0 top "resname SOL and z < 140 and (x+y+z)<340"
mol modstyle 0 top "CPK 1.0 0.0 30.0 12.0"
mol modmaterial 0 top Glassy  # Set material to Glassy

# Selecting core of the nanoparticle
mol addrep top
mol modselect 1 top "resname COR"  
mol modstyle 1 top "CPK 3.0 2.0 30.0 12.0"
mol modmaterial 1 top Glassy  # Set material to Glassy

# Selecting aptes of the nanoparticle with the NH3 atoms hidden
mol addrep top
mol modselect 2 top "resname APT and not name NH3"  
mol modstyle 2 top "CPK 2.0 2.0 30.0 12.0"
mol modmaterial 2 top Glassy  # Set material to Glassy
mol modcolor 2 top "ColorID 2" 

# Selecting the NH3 atoms of the aptes
mol addrep top
mol modselect 3 top "name NH3"
mol modstyle 3 top "CPK 3.0 2.0 30.0 12.0"
mol modmaterial 3 top Glassy  # Set material to Glassy
mol modcolor 3 top "ColorID 0"

# Selecting the CL ions
mol addrep top
mol modselect 4 top "resname CLA"
mol modstyle 4 top "CPK 3.0 0.0 30.0 12.0"
mol modmaterial 4 top Glassy  # Set material to Glassy
mol modcolor 4 top "ColorID 7"

# Selecting the NA ions
mol addrep top
mol modselect 5 top "resname POT"
mol modstyle 5 top "CPK 4.0 0.0 30.0 12.0"
mol modmaterial 5 top Glassy  # Set material to Glassy
mol modcolor 5 top "ColorID 30"

# Selecting the ODA surfactants with the NH2 atoms hidden
mol addrep top
mol modselect 6 top "resname ODN and z > 90 and not name NH2"
mol modstyle 6 top "CPK 2.0 2.0 30.0 12.0"
mol modmaterial 6 top Glassy  # Set material to Glassy
mol modcolor 6 top "ColorID 3"

# Selecting the NH2 atoms of the ODA surfactants
mol addrep top
mol modselect 7 top "name NH2 and z > 90"
mol modstyle 7 top "CPK 3.0 2.0 30.0 12.0"
mol modmaterial 7 top Glassy  # Set material to Glassy
mol modcolor 7 top "ColorID 3"

# Selecting oil molecules
mol addrep top
mol modselect 8 top "resname D10 and z > 90 and (x+y+z)<340"
mol modstyle 8 top "CPK 1.0 2.0 30.0 12.0"
mol modmaterial 8 top Glassy  # Set material to Glassy

# Reset the view
display resetview
display projection Orthographic
axes location Off
display depthcue on

light 1 on
light 2 on
light 3 off
light 4 off

rotate z by -65
rotate y by 0
rotate x by -85

scale by 1.6
translate by 0 -0.3 0

pbc box
pbc box -width 6 -color black
display resize 4800 4800
set env(VMDOPTIXWRITEALPHA) 1
render TachyonLOptiXInternal structure_100Oda.png