" non ruby files related to Ruby
autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
autocmd BufNewFile,BufRead Puppetfile setfiletype ruby
autocmd BufNewFile,BufRead Rakefile setfiletype rake
autocmd BufNewFile,BufRead Rakefile set syntax=ruby
autocmd BufNewFile,BufRead *.rake setfiletype rake
autocmd BufNEwFile,BufRead *.rake set syntax=ruby
autocmd FileType ruby,eruby set filetype=ruby.eruby.chef

let g:syntastic_ruby_checkers = ['rubocop']
