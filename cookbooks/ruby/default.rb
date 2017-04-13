package 'gcc'
package 'openssl'
package 'libssl-dev'
package 'zlib1g-dev'
package 'libreadline-dev'

git 'rbenv' do
  user node.user.name
  repository 'https://github.com/rbenv/rbenv.git'
  destination '/home/pokotyamu/.rbenv'
end

git 'ruby-build' do
  user node.user.name
  repository 'https://github.com/rbenv/ruby-build.git'
  destination '/home/pokotyamu/.rbenv/plugins/ruby-build'
end

execute 'init rbenv' do
  user node.user.name
  command '/home/pokotyamu/.rbenv/bin/rbenv init -'
  not_if '/home/pokotyamu/.rbenv/bin/rbenv -v'
end

directory '/home/pokotyamu/.rbenv/shims' do
  owner node.user.name
  group node.user.name
  action :create
end

directory '/home/pokotyamu/.rbenv/versions' do
  owner node.user.name
  group node.user.name
  action :create
end

execute 'add rbenv settings into /home/pokotyamu/.zshrc' do
  command %|echo 'export RBENV_ROOT="/home/pokotyamu/.rbenv"' >> /home/pokotyamu/.zshrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/pokotyamu/.zshrc
echo 'eval "$(rbenv init -)"' >> /home/pokotyamu/.zshrc
|
  not_if 'grep "RBENV_ROOT" /home/pokotyamu/.zshrc'
end

execute "install ruby 2.4.0" do
  user node.user.name
  command "/home/pokotyamu/.rbenv/bin/rbenv install 2.4.1"
  not_if '/home/pokotyamu/.rbenv/bin/rbenv versions | grep 2.4.1'
end
