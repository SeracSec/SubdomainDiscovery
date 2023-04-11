#!/bin/bash
echo 'Checking Dependencies'
[[ ! -a $(which subfinder) ]] && echo 'Subfinder not found, exiting' && exit
[[ ! -a $(which ripgen) ]] && echo 'Ripgen not found, exiting' && exit
[[ ! -a $(which dnsx) ]] && echo 'Dnsx not found, exiting' && exit
echo 'All dependencies found'

read -p "Domain to query: " domain
while [[ -z $domain ]]
do
        read -p "Domain required. Domain to query: " domain
done
read -p "Directory to store output files [/home/$(whoami)]: " outputDir
while [[ -z $outputDir ]]
do
        outputDir="/home/$(whoami)"
done
host=$(echo "$domain" | cut -d '.' -f1)
subfinderOutput="${outputDir}/${host}_subfinder.txt"
ripgenOutput="${outputDir}/${host}_ripgen.txt"
dnsxOutput="${outputDir}/${host}_dnsx.txt"
subdomainOutput="${outputDir}/${host}_subdomains_found.txt" 

echo '*****Running subfinder****'
subfinder -silent -d $domain -r 8.8.8.8,8.8.4.4,1.1.1.1,9.9.9.9 -nW -o $subfinderOutput
echo
echo '****Running ripgen****'
cat $subfinderOutput | ripgen > $ripgenOutput
echo
echo '****Running dnsx****'
cat $ripgenOutput | dnsx -t 1000 -silent -o $dnsxOutput
cat $subfinderOutput $dnsOutput | sort | uniq > $subdomainOutput
echo
echo '------------------------------------------------------------'
echo 'Found Resolved Subdomains:'
cat $subdomainOutput
echo
echo '------------------------------------------------------------'
echo "Files written:"
echo "Subfinder output: $subfinderOutput"
echo "Ripgen output: $ripgenOutput"
echo "Dnsx output: $dnsxOutput"
echo "Resolved subdomains found: $subdomainOutput"
echo
