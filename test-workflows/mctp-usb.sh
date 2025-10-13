
mctp_link=`mctp link|grep mctpusb | awk '{print $2}'`
echo $mctp_link
if [ "$mctp_link" == "" ];then
    echo "MCTP link not found"
    exit 1
fi

mctp link set mctpusb0 up
mctp addr add 50 dev mctpusb0
mctp link set mctpusb0 net 11

systemctl stop mctpd.service
systemctl start mctpd.service
busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0