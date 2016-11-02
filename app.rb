#!/usr/bin/env ruby

require 'fileutils'

extensions = {
  image: ['jpg','png'],
  audio: ['mp3'],
  video: ['mp4', 'mkv','3gp','mpeg'],
  office: ['xls', 'xlsx','doc','docx','ppt','pptx'],
  archive: ['zip', 'tar','tar.gz','tar.bz','rar'],
  language: ['rb', 'py','php','js','css','less','sass'],
  executable: ['exe', 'sh','msi','bat'],
}

directories = [
  'myFolders', 'myImage', 
  'myVideo', 'myMusic', 
  'myCode', 'myOffice',
  'myArchive','myOther' ]

  relation = {
    myFolders: ['folder'],
    myOther: ['other'],
    myImage: ['image'],
    myVideo: ['video'],
    myMusic: ['audio'],
    myCode: ['language', 'executable'],
    myOffice: ['office'],
    myArchive: ['archive'],
  }

  @myPath = '/home/devlife/Desktop/tmp/';

  @dir = directories 
  @exe = extensions 
  @rel = relation

  def dir_handler(dirs)
    dirs.each do |dir|
      if !Dir.exist?(@myPath + dir.to_s)
        dir_make(dir.to_s)
      end
    end
  end


  def dir_make(dir)
    Dir.mkdir(@myPath + dir)
  end

  def get_all_files
    return Dir[@myPath + "*"]
  end

  def get_abs_filename(file)
    return file.split(/\//)[-1]
  end

  def get_extension(file)
    return get_abs_filename file.split(".")[-1]
  end

  def get_folder(dic,el)
    dic.each do |key,value|
     value.each do |e|
      if el == e
        return key
      end
     end
   end
 end

 def clean_move(file)

  if File.directory?(file)
    if !@dir.include?(get_abs_filename(file))
      FileUtils.mv(file, @myPath+"myFolders")
    end
  else
    dir = get_folder(@exe , get_extension(file))
    puts file
    puts dir
    # puts get_folder(@rel ,dir)
    abort
  end 

end



def clean_handler(dir, exe) 
  dir_handler(dir)
  get_all_files.each do |file|
    clean_move(file.to_s)
  end
end



# dir_handler(directories)

clean_handler(directories, extensions)