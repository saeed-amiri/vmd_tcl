# visualization of all the ODA N atoms and overlay them from all frames in one plot 
# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1
mol delete all

# Define a procedure to load a molecule
proc load_molecule {grofile trrfile} {
    # Delete all molecules
    mol delete all
    # Load the molecule
    set mol [mol load gro $grofile]
    mol addfile $trrfile type trr first 0 last -1 step 1 waitfor all

}

# Define a procedure to delete all representations
proc delete_all_reps {} {
    # Get the number of representations
    set numreps [molinfo top get numreps]

    # Delete all representations
    for {set i 0} {$i < $numreps} {incr i} {
        mol delrep 0 top
    }
}

proc visualize_residues {repIndex selection radius} {
    # Add a new representation with the specified selection
    mol addrep top
    mol modselect $repIndex top $selection
    mol modstyle $repIndex top "CPK $radius 0.0 30.0 12.0"
    mol modmaterial $repIndex top Glassy
}

proc reset_view_and_display {} {
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off
}

proc render_image {filename} {
    display resize 4800 4800
    render TachyonLOptiXInternal $filename
}


# Load the trajectory
set grofile npt.gro
set trrfile npt.trr

load_molecule $grofile $trrfile

# Add a new representation
mol addrep top
delete_all_reps

# Visualize the residues
visualize_residues 0 "name NH2" 4.0
mol modcolor 0 top "ColorID 3"

# Draw multiple frames
mol drawframes top 0 {0:1000}
reset_view_and_display
# Render the image
set filename "overlay.png"
render_image $filename
exit

 
The script above will generate the following image: 
The image shows the overlay of all the ODA N atoms from all the frames in the trajectory. 
