killall -9 frpc
echo  >> ~/.frp/logfrp.log
/usr/bin/frpc -c ~/.frp/frpc.conf &
sleep 5
cat /root/.frp/*.log
