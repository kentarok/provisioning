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
    manage_home true
  end
  
  directory "/home/#{attr[0]}/.ssh" do
    owner attr[0]
    group attr[2]
  end
end

remote_file '/home/kentarok/.ssh/id_handson' do
  source 'https://raw.githubusercontent.com/kentarok/provisioning/master/handson/id_handson'
end

file '/home/kentarok/.ssh/authorized_keys' do
  content IO.read('/root/.ssh/authorized_keys')
  owner 'kentarok'
  owner '1999'
end

%w(0 1 2).each do | i |
  file "/home/#{userdata[i.to_i][0]}/.ssh/authorized_keys" do
    content IO.read('/home/kentarok/.ssh/id_handson')
    owner "#{userdata[i.to_i][0]}"
    group "#{userdata[i.to_i][2]}"
  end
end

__END__

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
