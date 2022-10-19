user 'server' do
    comment 'The server user'
    uid 1234
    home '/home/server'
    shell '/bin/bash'
  end
  
  directory '/home/server' do
    owner 'server'
    group 'server'
    mode '0755'
    action :create
  end
  
  remote_file '/home/server/server.jar' do
    source 'https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar'
    owner 'server'
    group 'server'
    mode '0755'
    action :create
  end
  
  openjdk_install '17'
  
  file "/home/server/eula.txt" do
    content "eula=true\n"
    mode 0644
    action :create
  end
  
  file "/etc/systemd/system/minecraft.service" do
    content "[Service]
  User=server
  WorkingDirectory=/home/server/
  ExecStart= java -Xmx1024M -Xms1024M -jar server.jar nogui"
    mode 755
    action :create
  end   
  
  execute 'Run server' do
    command 'sudo systemctl start minecraft.service'
  end
  
  execute 'Run server on startup' do
    command 'sudo systemctl enable minecraft.service'
  end