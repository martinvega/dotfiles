require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_oh_my_zsh
  switch_to_zsh
  
  puts %x{git submodule foreach git checkout master}

  copy_files
end

private

def copy_files
  replace_all = false
  
  files = Dir['*'] - %w[git gitignore gitconfig zshrc]

  files.each do |file|
    puts %x{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//

    if File.exist?(file_in_home(file.sub(/\.erb$/, '')))
      if File.identical? file, file_in_home(file.sub(/\.erb$/, ''))
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case ask_user_input
        when 'a'
          replace_all = true

          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

def ask_user_input
  $stdin.gets.chomp
end

def file_in_home(*args)
  File.join(ENV['HOME'], *args)
end

def replace_file(file)
  puts %x{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}

  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(file_in_home(file.sub(/\.erb$/, ''), 'w')) do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    puts %x{ln -s "$PWD/.#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV['SHELL'] =~ /zsh/
    puts 'using zsh'
  else
    print 'switch to zsh? (recommended) [ynq] '
    case ask_user_input
    when 'y'
      puts 'switching to zsh'
      puts %x{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts 'skipping zsh'
    end
  end
end

def install_oh_my_zsh
  if File.exist?(file_in_home('.oh-my-zsh'))
    puts 'found ~/.oh-my-zsh'
  else
    print 'install oh-my-zsh? [ynq] '
    case ask_user_input
    when 'y'
      puts 'installing oh-my-zsh'

      puts %x{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts 'skipping oh-my-zsh, you will need to change ~/.zshrc'
    end
  end
end
