#!/bin/sh
SERVICE="scream"
INTERFACE="virbr0"
VM="win10"
FLAG="-i"
FLAG2="-o"
RECEIVER="pulse"
VIRSHFLAG="start"
STATE=$(virsh list --all | grep " $VM " | awk '{ print $3}')
if pgrep "$SERVICE" > /dev/null 2>&1 
then
	PID=$(pgrep "$SERVICE")
	echo "$SERVICE is running. (PID=$PID)"
else
	echo "Starting $SERVICE"
	/opt/scream/Receivers/unix/build/scream $FLAG $INTERFACE $FLAG2 $RECEIVER &
	PID=$(pgrep "$SERVICE")
fi
if [[ "x$STATE" ==  "xavstängd" ]]
then
	echo "$VM state = $STATE, starting $VM..."
	virsh $VIRSHFLAG $VM > /dev/null 2>&1
else
	echo "$VM state = $STATE"
fi
echo "Starting Looking-Glass..."
/opt/looking-glass-B3/client/build/looking-glass-client > /dev/null 2>&1

if [[ "x$STATE" == "xavstängd" ]]
then
	echo "ggwp"
	kill $PID
fi
