execute 'download go 1.7.5 binaly' do
  user node.user.name
  cwd '/home/pokotyamu'
  command 'wget https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz'
  not_if 'ls /home/pokotyamu/go1.7.5.linux-amd64.tar.gz'
end

execute 'decompless go binaly tarball' do
  command 'tar -C /usr/local -xzf /home/pokotyamu/go1.7.5.linux-amd64.tar.gz'
  not_if 'ls /usr/local/go'
end

execute 'add go pathes into .zshrc' do
  user node.user.name
  command %|echo 'export GOROOT="/usr/local/go"' >> /home/pokotyamu/.zshrc
echo 'export GOPATH="/home/pokotyamu/go"' >> /home/pokotyamu/.zshrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> /home/pokotyamu/.zshrc
|
  not_if 'grep "go/bin" /home/pokotyamu/.zshrc'
end
