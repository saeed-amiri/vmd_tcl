# The helped-procedure to visulise the data
source /scratch/saeed/MyScripts/vmd_tcl/src/elsevier_style.tcl
# Define a procedure to load a molecule
proc load_molecule {style filename} {
    # Delete all molecules
    mol delete all
    # Load the molecule
    set mol [mol load $style $filename]
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

# Define a procedure to render an image
proc render_image {filename} {
    # Access the variables from the sizes namespace
    global sizes::width_in_pixels
    global sizes::height_in_pixels
    display resize $width_in_pixels $height_in_pixels
    render TachyonLOptiXInternal $filename
}

# set the view and display
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

proc white_background {} {
    color Display Background white
}

# Define a procedure with parameters
proc visualize_residues {repIndex selection radius} {
    # Add a new representation with the specified selection
    mol addrep top
    mol modselect $repIndex top $selection
    mol modstyle $repIndex top "CPK $radius 0.0 30.0 12.0"
    mol modmaterial $repIndex top Glossy
}

# Define a procedure to rotate the molecule
proc rotate_view {anglex angley anglez} { 
    rotate x by $anglex
    rotate y by $angley
    rotate z by $anglez
}

# Define a procedure to add periodic boundary conditions
proc add_pbc {color width} {
    pbc box -color $color -width $width -material Opaque
}

proc remove_pbc {} {
    pbc box -off
}
