require 'spec_helper'

set :os, family: :ubuntu

describe docker_container('marathon') do
  it { should be_running }	
#  its(:HostConfig_NetworkMode) { should eq 'host' }
#  its(:Path) { should eq '/bin/sh' }
end

describe process("java") do
  its(:args) { should match "-jar ./bin/../target/scala-2.11/marathon-assembly-0.8.1.jar --hostname 172.31.1.14 --task_launch_timeout 300000 --master zk://172.31.1.14:2181/mesos --zk zk://172.31.1.14:2181/marathon" }
end
