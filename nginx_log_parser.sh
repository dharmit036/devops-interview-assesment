#!/bin/bash
get_report() {
	nginx_log_path="/var/log/nginx/access.log"
	echo -e "This script will display top users as per given choices:\n[1] By IP wise\t[2] By bandwidth usage as per user wise"
	read choices
	if [[ $choices == "1" ]]
	then
		ip_counters=$(awk '{print $1}' ${nginx_log_path} | sort | uniq -c | sort -nr)
		echo -e "Top users:\n${ip_counters}"
	else
		bandwidth_counters=$(awk 'BEGIN{ PROCINFO["sorted_in"]="@val_num_desc" }
     							{ x[$1]++; y[$1]+=$10; }
     							END{ 
         							for(i in x) { if(++z>10) break; print i,y[i] } 
     						}' ${nginx_log_path} | sort  )
		echo -e "Top users:\n${bandwidth_counters}"
	fi

}

get_report