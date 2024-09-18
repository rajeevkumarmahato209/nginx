#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using rajeev
ORG=${1:-rajeev}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
PEER0_rajeev_CA=${DIR}/test-network/organizations/peerOrganizations/rajeev.example.com/tlsca/tlsca.rajeev.example.com-cert.pem
PEER0_kumar_CA=${DIR}/test-network/organizations/peerOrganizations/kumar.example.com/tlsca/tlsca.kumar.example.com-cert.pem
PEER0_ORG3_CA=${DIR}/test-network/organizations/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem


if [[ ${ORG,,} == "rajeev" || ${ORG,,} == "digibank" ]]; then

   CORE_PEER_LOCALMSPID=rajeevMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/rajeev.example.com/users/Admin@rajeev.example.com/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/rajeev.example.com/tlsca/tlsca.rajeev.example.com-cert.pem

elif [[ ${ORG,,} == "kumar" || ${ORG,,} == "magnetocorp" ]]; then

   CORE_PEER_LOCALMSPID=kumarMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/kumar.example.com/users/Admin@kumar.example.com/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/kumar.example.com/tlsca/tlsca.kumar.example.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose rajeev/Digibank or kumar/Magnetocorp"
   echo "For example to get the environment variables to set upa kumar shell environment run:  ./setOrgEnv.sh kumar"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo 'export $(./setOrgEnv.sh kumar | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_rajeev_CA=${PEER0_rajeev_CA}"
echo "PEER0_kumar_CA=${PEER0_kumar_CA}"
echo "PEER0_ORG3_CA=${PEER0_ORG3_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
