require 'pry'
puts ""

# the directory your rar filese reside within (converted to unix format)
path = 'E:\Downloads\uTorrent - Completed'.gsub(/\\/,'/')

# the directory for the UnRAR executable
# download from http://www.rarlab.com/rar/unrarw32.exe
unrar_path = 'C:\Program Files (x86)\Unrar\UnRAR.exe' #.gsub(/\\/,'/')

# output directory if you do not wish to extract to the same folder as the rar
output_path = 'E:\Downloads\uTorrent - Completed'

# extract switches
switches = 'e -x'

# count archives extracted
counter = 0

Dir.glob("#{path}/**/*part01.rar") do |filepath|
	# puts filepath
    parts = filepath.split('/')
    # the filename to be extracted (part01.rar)
    filename = parts.pop
    # the path this file resides (and where to extract)
    path = parts.join('\\')
    
    # output details to the user
    puts "------------------------------------------------------------------------"
    puts " Filename: #{filename}"
    puts " Path: #{path}"
    puts "------------------------------------------------------------------------"

    # perform extraction (to the same folder as the .rar files)
    system "\"#{unrar_path}\" #{switches} \"#{filepath}\" \"#{output_path}\""

    # delete the folder containing the archive
    system "RD /S /Q \"#{path}\""
    # inform the usere the file was deleted
    puts "------------------------------------------------------------------------"
    puts " Deleting: #{path}"
    puts "------------------------------------------------------------------------"
end

puts ""
puts "------------------------------------------------"
puts "Extracting Complete - #{counter} files extracted"
puts "------------------------------------------------"

exec "pause"
# exec "exit"



# TESTING ONLY

# test_file = 'E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F\ultimate.survival.alaska.s02e07.vice.grip.hdtv.x264-w4f.part01.rar'
# output_dir = 'E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F'
# system "\"#{unrar_path}\" #{switches} \"#{test_file}\" \"#{output_dir}\""

#PROMPT USER TO CONFIRM TO EXTRACT OR JUST QUIT (STILL LISTING FILES)

# COMMAND EXAMPLE 
# unrar e -x "E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F\ultimate.survival.alaska.s02e07.vice.grip.hdtv.x264-w4f.part01.rar" "E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F"

# REGEX (UNUSED)
# if /part01.rar\z/ =~ filepath
