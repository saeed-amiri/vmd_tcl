# To visualize the potential layer. The layers are shown with lines.
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl


set GRO ./apt_cor_0.gro
set PQR ./apt_cor_0.pqr
set DX ./average_potential.dx

# Define a list for the center of the sphere
set ZLayersIndices {40 50 60 80 100 110 120 130}
set GridNr {161 161 161}


proc visualize_system_face_cut {} {
    # Selecting water molecules
    mol delrep 0 top
    visualize_residues 0 "resname SOL and x < 109" 2.0
    # Selecting core of the nanoparticle
    visualize_residues 1 "resname COR and x < 109" 3.0
    # Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 "resname APT and not name N and x < 109" 2.0
    mol modcolor 2 top "ColorID 2"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 3 {name N and x < 109} 3.0
    mol modcolor 3 top "ColorID 0"
    # Selecting the CL ions
    visualize_residues 4 "resname CLA and x < 109" 3.0
    mol modcolor 4 top "ColorID 7"
    # Selecting the NA ions
    visualize_residues 5 "resname POT and x < 109" 4.0
    mol modcolor 5 top "ColorID 30"
    # Selecting the ODA surfactants with the NH2 atoms hidden
    visualize_residues 6 {name "HA.* and x < 109"} 2.0
    mol modcolor 6 top "ColorID 8"
    visualize_residues 7 "resname ODN and x < 109 and not name NH2" 2.0
    mol modcolor 7 top "ColorID 2"
    # Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 8 "name NH2 and x < 109" 4.0
    mol modcolor 8 top "ColorID 3"
    # Selecting oil molecules
    visualize_residues 9 "resname D10 and x < 109" 2.0
    mol modcolor 9 top "ColorID 4"
    # visualize_residues 10 "resname APT and 'HA.*'" 2.0
    # mol modcolor 10 top "ColorID 2"

}
# Use the list in the graphics command
set 0 [mol new $GRO type gro waitfor all]

# mol addfile $DX type dx first 0 last -1 step 1 waitfor 1 volsets 0 $mol_i
set cell [pbc get -now]
# set cell [list 238.39750 237.79750 215.77437]

set cellX [lindex $cell 0 0]
set cellY [lindex $cell 0 1]
set cellZ [lindex $cell 0 2]
set CenterX [expr $cellX/2]
set CenterY [expr $cellY/2]
set CenterZ [expr $cellZ/2]

set GridSpacing [expr $cellZ/161]

graphics top color black

# Iterate over all indices in ZLayersIndices
foreach idx $ZLayersIndices {
    # Calculate the plane position for the current index
    set plane_i [expr $GridSpacing * $idx]
    puts  "$idx  ->  $plane_i"
    # Draw a line at the calculated plane position
    graphics top line [list 0 $CenterY $plane_i] [list 165 $CenterY $plane_i] width 2
    
    # Place text indicating the index of the Z layer
    graphics top text [list 169 $CenterY $plane_i] "i = $idx" size 1
}

visualize_system_face_cut
# mol delete all
# mol selection all
reset_view_and_display
white_background
# visualize_residues 0 "all and x < 109" 3
rotate_view -90 0 0
# add a sphere to show the cut-off radius
# Circle parameters

add_pbc black 3.0
graphics top color red3
graphics top sphere [list $CenterX $CenterY $CenterZ] radius 36.0 resolution 1000
graphics top material Transparent


# mol modstyle 0 0 "Isosurface 2.95 0 0 0 1 1"
# mol modmaterial 0 0 MetalicPlastic
# mol modcolor 0 0 "ColorID 24"

render TachyonInternal "test.tga" -aasamples 12


exit