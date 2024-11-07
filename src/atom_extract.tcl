
    # Load the gro and trr and with optinal number of frames
    set mol [mol new ./np_centered_whole.gro  type gro waitfor all]
    puts "Attempting to load file: $mol"
    set distance 3.6

    mol addfile ./np_centered_whole.trr type trr first 0 last -1 step 1    waitfor all molid $mol

    set nf [molinfo top get numframes]
    puts " The numbers of frames are $nf"
    for {set i 0} {$i < $nf} {incr i} {
        animate goto $i
        # set inRadiusResidues [atomselect top "within $distance of resname APT COR"]
        set inRadiusResidues [atomselect top "((within $distance of resname APT COR) or (resname D10 and z > 130 and z < 160)) and (not resname ODN)"]

        set resIDs [$inRadiusResidues get residue]
        if {[llength $resIDs] > 0} {
            set uniqueResIDs [lsort -unique $resIDs]
            set completeInRadiusResidues  [atomselect top "residue $uniqueResIDs"]
            $completeInRadiusResidues writegro "./apt_cor_${i}.gro"
            $completeInRadiusResidues delete
        } else {
            puts "No residues within $distance Å of APT or COR in frame $i"
        }
        $inRadiusResidues delete
    }

    exit
