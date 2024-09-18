#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=rajeev
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/rajeev.example.com/tlsca/tlsca.rajeev.example.com-cert.pem
CAPEM=organizations/peerOrganizations/rajeev.example.com/ca/ca.rajeev.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/rajeev.example.com/connection-rajeev.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/rajeev.example.com/connection-rajeev.yaml

ORG=kumar
P0PORT=9051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/kumar.example.com/tlsca/tlsca.kumar.example.com-cert.pem
CAPEM=organizations/peerOrganizations/kumar.example.com/ca/ca.kumar.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/kumar.example.com/connection-kumar.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/kumar.example.com/connection-kumar.yaml
