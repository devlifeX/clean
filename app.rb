#!/usr/bin/env ruby

require 'fileutils'


# mime = [
#   'application', 'audio',
#  'chemical', 'font', 'image',
#   'message', 'model', 'multipart',
#    'text', 'video', 'conference',
#     'shader']

extensions = {
  image: ['jpg','png','gif', 'image','font'],
  audio: ['mp3','audio'],
  video: ['mp4', 'mkv','3gp','mpeg', 'ogv','video'],
  office: ['xls','message', 'xlsx','doc','docx','ppt','pptx', 'txt', 'pdf','csv','tsv'],
  archive: ['zip', 'tar','gz','bz','rar','bz2'],
  application: ['rb','text','conference','shader','chemical','model','multipart', 'py','php','js','css','less','sass','sql','html','json','application'],
  executable: ['exe', 'sh','msi','bat'],
}

directories = [
  'myFolder', 'myImage', 
  'myVideo', 'myMusic', 
  'myApp', 'myOffice',
  'myArchive','myOther' ]

  relation = {
    myFolder: ['folder'],
    myOther: ['other'],
    myImage: ['image'],
    myVideo: ['video'],
    myMusic: ['audio'],
    myApp: ['application', 'executable'],
    myOffice: ['office'],
    myArchive: ['archive'],
  }

  @myPath = '';

  @dir = directories 
  @exe = extensions 
  @rel = relation

  def dir_handler(dirs)
    dirs.each do |dir|
      if !File.exist?(@myPath + dir.to_s)
        dir_make(@myPath + dir.to_s)
      end
    end
  end


  def dir_make(dir)
    Dir.mkdir(dir)
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

  def get_folder_from_mime(file)
    new_file = file.gsub(" ", "\\ ");
    mime = %x[file -ib #{new_file}]
    return mime.split(';')[0].split('/')[0]
  end

  def get_folder(dic,el, file = '')      
    dic.each do |key,value|
      value.each do |e|
        if el.to_s == e.to_s
          return key.to_s
        end
      end
    end

    return get_folder(@rel, 'other')
  end



  def clean_move(file)

    allow_move = false

    folder = get_folder(@rel ,'other')

    if File.directory?(file)
      if !@dir.include?(get_abs_filename(file))
        allow_move = true
        folder = get_folder(@rel ,'folder')
      end
    else
      allow_move = true
      dir = get_folder(@exe , get_extension(file))
      if dir == get_folder(@rel ,'other')
        mime = get_folder_from_mime(file)
        dir = get_folder(@exe ,mime)
        folder =  get_folder(@rel ,dir)
      else
        folder = get_folder(@rel ,dir)
      end
    end 

    if allow_move
      FileUtils.mv(file, @myPath + folder)
    end

  end


  def clean_handler(dir, exe) 
    dir_handler(dir)
    get_all_files.each do |file|
      clean_move(file.to_s)
    end
  end


  def command_line_handler()
    path = ARGV[0]

    path =  path || "here"

    if path.downcase == "here"
      @myPath = Dir.pwd
    else
      unless File.exist? path
        puts 'path is not valid!'
        exit
      end
      @myPath = path
    end
    @myPath += "/"
    clean_handler(@dir, @exe)
  end

  command_line_handler()