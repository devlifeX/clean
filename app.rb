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
  myImage: ['image'],
  myVideo: ['video'],
  myMusic: ['audio'],
  myCode: ['language', 'executable'],
  myOffice: ['office'],
  myArchive: ['archive']
}