every '30 * * * *' do
  command 'export LANG=ja_JP.UTF-8;export PATH="/usr/local/rbenv/bin:$PATH";eval "$(rbenv init -)";cd ~/collect_pm25;ruby crawl.rb'
end

