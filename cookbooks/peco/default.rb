execute 'go get peco' do
  user node.user.name
  command 'env GOPATH="/home/pokotyamu/go" /usr/local/go/bin/go get github.com/peco/peco/cmd/peco'
  not_if 'ls /home/pokotyamu/go/bin/peco'
end

execute 'set alias' do
  command %[echo 'alias gmv="cd $(ghq root)/$(ghq list | peco)"' >> /home/pokotyamu/.zshrc]
  not_if 'grep "alias gmv" /home/pokotyamu/.zshrc'
end
