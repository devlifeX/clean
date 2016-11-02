#!/usr/bin/env ruby

require 'fileutils'

extensions = {
  image: ['jpg','png','gif'],
  audio: ['mp3'],
  video: ['mp4', 'mkv','3gp','mpeg', 'ogv'],
  office: ['xls', 'xlsx','doc','docx','ppt','pptx', 'txt', 'pdf','csv','tsv'],
  archive: ['zip', 'tar','gz','bz','rar','bz2'],
  language: ['rb', 'py','php','js','css','less','sass','sql','html','json'],
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

  def get_folder(dic,el)
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

    if File.directory?(file)
      if !@dir.include?(get_abs_filename(file))
        allow_move = true
        folder = get_folder(@rel ,'folder')
      end
    else
      allow_move = true
      dir = get_folder(@exe , get_extension(file))
      folder = get_folder(@rel ,dir)
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