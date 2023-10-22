#----------------------------------------------------------------------
# Set Project name
#----------------------------------------------------------------------
set project_name $env(PROJECT_NAME)
puts "Project name : ${project_name}"

#----------------------------------------------------------------------
# Set Project directory
#----------------------------------------------------------------------
set project_dir $env(WEB_SDR_IMPL_PATH)

#----------------------------------------------------------------------
# Create vivado project
#----------------------------------------------------------------------
create_project $project_name $project_dir -part xc7a35tcpg236-1 -force
set_property board_part digilentinc.com:basys3:part0:1.2 [current_project]

#----------------------------------------------------------------------
# Import (V)HDL sources
#----------------------------------------------------------------------
set fileset_name "sources_1"
set_property target_language VHDL [current_project]

# Interpréter les variables d'environnement dans le chemin du fichier
#regsub -all -line -- {(\$[A-Z_]+)} $file_path [list set file_path [string map [array get env] $file_path]] file_path

set filelist_path [open "$env(WEB_SDR_DESIGN_PATH)/web_sdr_rtl_filelist.fl" r]
set content [read $filelist_path]
close $filelist_path


set lines [split $content "\n"]
puts $lines

foreach line $lines {
    # Traitement de chaque ligne ici, par exemple :
    puts "Ligne lue : $line"
    regsub -all -line -- {(\$[A-Z_]+)} $line [string map [array get env] $line] line
    puts "Ligne retrascrite : $line"
    set source_file [string range $line 1 end]
    puts "Ligne finale  : $source_file"
}


set ma_chaine {Ceci est un exemple de $PROJECT_NAME contenu.}
regsub -all {\$([A-Z_]+)} $ma_chaine [list set ma_chaine [string map [array get env] $ma_chaine]] ma_chaine
puts $ma_chaine
set ma_chaine {Ceci est un autres exemple de $PROJECT_NAME contenu.}
regsub -all {\$([A-Z_]+)} $ma_chaine [list set ma_chaine [string map [array get env] $ma_chaine]] ma_chaine
puts $ma_chaine


#regsub -all -line -- {(\$[A-Z_]+)} $file_path [string map [array get env] $file_path] file_path



#puts $file_path

#regsub -all -line -- {(\$[A-Z_]+)} $file_path [list set file_path [string map [array get env] $file_path]] file_path
#import_files -fileset [get_filesets sources_1] $env(WEB_SDR_DESIGN_PATH)/web_sdr_rtl_filelist.fl
#add_files -fileset sources_1 [read [open $env(WEB_SDR_DESIGN_PATH)/web_sdr_rtl_filelist.fl]]

#set filelist_path [open "$env(WEB_SDR_DESIGN_PATH)/web_sdr_rtl_filelist.fl" r]
#set file_path [gets $filelist_path]

#set evaluated_path [file normalize [subst -nocommands $file_path]]

#set files_list {
#booth_radix_4
#}

#foreach el $liste {
#vcom   -cover bcesx ../rtl/$el.vhd
#}


#----------------------------------------------------------------------
# Import constraints
#----------------------------------------------------------------------
#add_files -fileset constrs_1 -norecurse $env(WEB_SDR_CONSTRAINTS_PATH)/basys_3.xdc

#----------------------------------------------------------------------
# FIles Analyse
#----------------------------------------------------------------------
#update_compile_order -fileset sources_1

