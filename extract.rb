# require 'pry'

puts ""

# GLOBAL VARIABLES REQUIRED

# the directory for the UnRAR executable
# download from http://www.rarlab.com/rar/unrarw32.exe
$unrar_path = 'C:\Program Files (x86)\Unrar\UnRAR.exe' #.gsub(/\\/,'/')

# extract switches
$switches = 'e -x'

# output directory if you do not wish to extract to the same folder as the rar
$output_path = 'E:\Downloads\uTorrent - Completed'

# ----------------------------------------------------------------

class RarFile

  attr_accessor :filename, :path

  def initialize(fullpath)
    #the full path including hte file name
    @fullpath = fullpath

    parts = fullpath.split('/')

    # the filename to be extracted (part01.rar)
    @filename = parts.pop

    # the path this file resides (and where to extract)
    @path = parts.join('\\')
  end

  def extract
    # run the command to extract the files
    system "\"#{$unrar_path}\" #{$switches} \"#{@fullpath}\" \"#{$output_path}\""
  end

  def delete
    # delete the folder that contained the files
    system "RD /S /Q \"#{@path}\""
  end

end

# ----------------------------------------------------------------

# the directory your rar filese reside within (converted to unix format)
path = 'E:\Downloads\uTorrent - Completed'.gsub(/\\/,'/')

# to track files extracted
files = []

# files to search for
# search = ['part01.rar','part1.rar']

# count archives extracted
counter = 0

# ----------------------------------------------------------------

# find the rar files
# search.each do |search_term|
# NOTE: can use /**/** to search down all subdirectories
Dir.glob("#{path}/**/*.rar") do |fullpath|

  # check if this is a 'PARTXX' rar file
  regex = /part(.{1,2})\.rar\z/.match(fullpath)

  # if this is a .rar OR part01.rar OR part1.rar then continue
  if regex == nil || regex[1] == '01' || regex[1] == '1'
    # add the file we've found
    file = RarFile.new(fullpath)
    files.push(file)
    counter += 1
  end
end
# end

# print out the files found
puts "---- #{counter} RAR files found ----"
files.each_with_index do |file,index|
  puts "[#{index + 1}]: #{file.filename}"
end

if files.count > 0

  # prompt user input
  puts ""
  puts "Press [E] and then [ENTER] to extract the rarfiles"
  puts "Press any other key to quit"
  puts "WARNING: The source directory will be deleted upon completion!"
  print "==> "

  command = gets.chomp.downcase

  case command
  # extract ONLY
  when 'e'
    files.each do |file|
      file.extract
      file.delete
    end
  end

end #if files.count > 0

exec "pause"



# TESTING ONLY

# test_file = 'E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F\ultimate.survival.alaska.s02e07.vice.grip.hdtv.x264-w4f.part01.rar'
# output_dir = 'E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F'
# system "\"#{unrar_path}\" #{switches} \"#{test_file}\" \"#{output_dir}\""

#PROMPT USER TO CONFIRM TO EXTRACT OR JUST QUIT (STILL LISTING FILES)

# COMMAND EXAMPLE 
# unrar e -x "E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F\ultimate.survival.alaska.s02e07.vice.grip.hdtv.x264-w4f.part01.rar" "E:\Downloads\uTorrent - Completed\Ultimate.Survival.Alaska.S02E07.Vice.Grip.HDTV.x264-W4F"
