#
# Cookbook Name:: chef_setup
# Recipe:: default
#
CACHE = Chef::Config[:file_cache_path]

userdata=[
  %w(user01 1991 myusers),
  %w(user02 1992 myusers),
  %w(user03 1993 myusers),
  %w(kentarok 1999 myadms),
]

package %w(zip unzip git tree)

group 'myusers' do
  gid '1991'
end

group 'myadms' do
  gid '1992'
end

userdata.each do | attr |
  user attr[0] do
    uid attr[1].to_i
    gid attr[2]
  end
end

service "sshd"

file "/etc/ssh/sshd_config" do
  f = Chef::Util::FileEdit.new(path)
  f.search_file_replace_line(/^#Port 22/, "Port 40022\n")
  f.search_file_replace_line(/^PasswordAuthentication yes/, "PasswordAuthentication no\n")
  content f.send(:editor).lines.join
  notifies :restart, 'service[sshd]', :immediately
end

file "/etc/sudoers" do
  f = Chef::Util::FileEdit.new(path)
  f.insert_line_if_no_match(/^%myadms ALL=(ALL) NOPASSWD: ALL/, '%myadms ALL=(ALL) NOPASSWD: ALL')
  content f.send(:editor).lines.join
end



