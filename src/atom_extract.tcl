
    # Load the gro and trr and with optinal number of frames
    set mol [mol new ./center_npt.gro  type gro waitfor all]
    puts "Attempting to load file: $mol"
    set distance 3.0

    mol addfile ./center_npt.trr type trr first 0 last -1 step 1    waitfor all molid $mol

    set nf [molinfo top get numframes]
    puts " The numbers of frames are $nf"
    for {set i 0} {$i < $nf} {incr i} {
        animate goto $i
        set inRadiusResidues [atomselect top "within $distance of resname APT COR"]
        set resIDs [$inRadiusResidues get residue]
        if {[llength $resIDs] > 0} {
            set uniqueResIDs [lsort -unique $resIDs]
            set completeInRadiusResidues            [atomselect top "residue $uniqueResIDs"]
            $completeInRadiusResidues writegro "extract_frames/apt_cor_${i}.gro"
            $completeInRadiusResidues delete
        } else {
            puts "No residues within $distance Å of APT or COR in frame $i"
        }
        $inRadiusResidues delete
    }

    exit

    