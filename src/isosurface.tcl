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
puts_decorated "Molecule ID: $mol_i"
mol addfile $potential type dx first 0 last -1 step 1 waitfor 1 volsets 0 $mol_i

mol selection all
# modcolor rep_number molecule_number coloring_method
mol modcolor 0 0 "ColorID 24"
# modmaterial rep_number molecule_number material_name
mol modmaterial 0 0 MetalicPlastic
# modstyle rep_number molecule_number style_name
mol modstyle 0 0 "Isosurface 17.3400000 0 0 0 1 1"
# addrep molecule_number
mol addrep 0
mol modcolor 1 0 "ColorID 1"
mol modmaterial 1 0 MetalicPlastic
mol modstyle 1 0 "Isosurface -17.340000 0 0 0 1 1"

render_image "isosurface000.png"
rotate_view 90 90 90
render_image "isosurface090.png"

exit