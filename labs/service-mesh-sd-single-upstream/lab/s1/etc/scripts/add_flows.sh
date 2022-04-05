ovs-ofctl add-flow s1 "priority=30,arp,nw_dst=192.168.1.250,action=mod_nw_dst:nw_src,mod_dl_dst:dl_src,mod_nw_src:192.168.1.250,mod_dl_src:00:00:00:ff:ff:ff,output:in_port"
ovs-ofctl add-flow s1 "priority=50,tcp,in_port=1,ip_dst=192.168.1.250,tp_dst=8080,action=ct(commit,zone=1,nat(dst=192.168.1.12:13427)),mod_dl_dst:00:00:00:00:00:02,output:2"
ovs-ofctl add-flow s1 "priority=50,tcp,in_port=2,ct_state=-trk,action=ct(table=0,zone=1,nat)"
ovs-ofctl add-flow s1 "priority=50,tcp,in_port=2,ip_dst=192.168.1.11,ct_state=+est,ct_zone=1,action=1"
