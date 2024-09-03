# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl
# source /scratch/saeed/MyScripts/vmd_tcl/src/modified_cliptool.tcl

puts "__________________________"
set potential [lindex $argv 0]
puts "potential: $potential"

proc load_molecule {type filename} {
    if {[file exists $filename]} {
        mol new $filename type $type
    } else {
        puts "Error: File $filename does not exist."
        exit 1
    }
}

puts "__________________________"

# Load the .dx file
load_molecule dx $potential
# Ensure the molecule is loaded before proceeding
if {[molinfo num] == 0} {
    puts "Error: No molecules loaded."
    exit 1
}

reset_view_and_display
color Display Background white
rotate z by -65
rotate y by 0
rotate x by -85

translate by 0.3 0. 0
scale by 1.33

delete_all_reps
set isosurface_values {4.00 3.00 2.00 0.0 -1.0 -2.0}
set color_ids {1 31 32 12 0 6}
set clipid 0
set molid 0
set repid 0
for {set i 0} {$i < [llength $isosurface_values]} {incr i} {
    set isosurface_value [lindex $isosurface_values $i]
    set color_id [lindex $color_ids $i]
    
    mol addrep $molid
    
    mol modstyle $repid $molid Isosurface $isosurface_value 0 0 0 1 1
    mol modcolor $repid $molid ColorID $color_id
    mol modmaterial $repid $molid Opaque
    
    # Set clipping planes
    mol clipplane center $clipid $repid $molid {180 0 0}
    mol clipplane color $clipid $repid $molid {1 0 0}
    mol clipplane normal $clipid $repid $molid {-0.58 -0.3 0}
    mol clipplane status $clipid $repid $molid 1
    
    incr clipid
    incr repid
}

# Increase rendering quality using TachyonInternal
# render TachyonInternal "potential_15da.tga" %s -res 1920 1080 -aasamples 24 -raydepth 8
render Tachyon potential.dat "/home/applications/software/vmd/vmd-1.9.4/tachyon_LINUXAMD64" -aasamples 12 %s -format TARGA -o %s.tga
exit
