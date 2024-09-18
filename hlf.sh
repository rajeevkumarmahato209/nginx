echo "-- Installing HLF--- "
curl -sSL https://bit.ly/2ysbOFE | bash -s
cd fabric-samples/test-network
./network.sh down
sleep 10
./network.sh up
sleep 10
./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go

