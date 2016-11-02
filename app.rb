#!/usr/bin/ruby

extensions = {
  image: ['jpg','png'],
  audio: ['mp3'],
  video: ['mp4', 'mkv','3gp','mpeg'],
  office: ['xls', 'xlsx','doc','docx','ppt','pptx'],
  archive: ['zip', 'tar','tar.gz','tar.bz','rar'],
  language: ['rb', 'py','php','js','css','less','sass'],
  executable: ['exe', 'sh','msi','bat'],
}



directories = {
  myFolders: ['folder'],
  myImage: ['image'],
  myVideo: ['video'],
  myMusic: ['audio'],
  myCode: ['language', 'executable'],
  myOffice: ['office'],
  myArchive: ['archive'],
}

@myPath = '/home/devlife/Desktop/tmp/';

def dir_handler(dirs)
  dirs.each do |dir, group|
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

def clean_move(file)
 if File.directory?(file)
  
 end 

end

def clean_handler(dir, exe) 
 get_all_files.each do |file|
  clean_move(file.to_s)
end
end



# dir_handler(directories)

clean_handler(directories, extensions)