task :deploy do
  sh "git push heroku master"
end

task :stats do
  sh "wc -l `find . -type f -name '*.hamlc'`"
  sh "wc -l `find . -type f -name '*.coffee'`"
end
