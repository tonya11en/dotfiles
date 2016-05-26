scp tony_* 192.168.5.253:/home/nutanix ;

sh ~/mk_rand_stats.sh 8k ;
sh ~/mk_rand_stats.sh 16k ;
sh ~/mk_rand_stats.sh 32k ;
sh ~/mk_rand_stats.sh 64k ;
sh ~/mk_rand_stats.sh 128k ;

sh ~/mk_seq_stats.sh 16k ;
sh ~/mk_seq_stats.sh 64k ;
sh ~/mk_seq_stats.sh 256k ;
sh ~/mk_seq_stats.sh 1M ;
