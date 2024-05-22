# to plot the electrostatic potential on the surface of the nanoparticle

package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl

mol delete all

proc puts_decorated {text} {
    puts "----------------------------------------"
    puts $text
    puts "----------------------------------------"
}

proc load_molecule {type filename} {
    if {[file exists $filename]} {
        mol new $filename type $type type gro first 0 last -1 step 1 waitfor 1 volsets 0
    } else {
        puts "Error: File $filename does not exist."
    }
}

# reset_view_and_display
set structure [lindex $argv 0]
set potential [lindex $argv 1]
puts_decorated "Structure: $structure, Potential: $potential"

set mol_i [load_molecule gro $structure]
mol addfile $potential type dx first 0 last -1 step 1 waitfor 1 volsets 0 $mol_i
mol selection all

# modmaterial rep_number molecule_number material_name
mol modmaterial 0 0 Opaque

# modcolor rep_number molecule_number coloring_method
mol modcolor 0 0 "Volume 0"

color Display Background 8
# scaleminmax molecule_number rep_number [min max | auto]
mol scaleminmax 0 0 -18 18

# modstyle rep_number molecule_number style_name
mol modstyle 0 0 "Surf 1.400000 0.000000"

# render_image "isosurface_volume.png"
render TachyonInternal "isosurface_volume.tga" -aasamples 12
rotate_view 90 90 90
# translate by 0.500000 0.510000 0.000000
render TachyonInternal "isosurface_volume_909090.tga" -aasamples 12

exit