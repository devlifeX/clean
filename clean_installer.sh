#!/bin/bash
sudo cp -rf app.rb /bin/clean.rb
sudo echo "alias clean='clean.rb'" >> ~/.bashrc
source ~/.bashrc