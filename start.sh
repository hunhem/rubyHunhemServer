ps aux | grep -ie [r]ails | awk '{print}'
ps aux | grep -ie [r]ails | awk '{print $2}' | xargs kill -9

bundle exec unicorn_rails -c config/unicorn.rb -E development -D
#bundle exec unicorn_rails -c config/unicorn.rb -E production -D
