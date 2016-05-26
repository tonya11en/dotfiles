mkdir -p ~/tony_stats ;

curl http://localhost:2009/rpc_stats/reset ; sshpass -p nutanix/4u ssh 192.168.5.253 "sh /home/nutanix/tony_seq.sh 6 240 $1" ; sleep 30 ; curl http://localhost:2009/rpc_stats/raw > ~/tony_stats/$1_seq.out ;
