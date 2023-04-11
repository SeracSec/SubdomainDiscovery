# Subdomain Discovery
## Usage
```./subdomain_discovery.sh ```

## Description
Shell script that will use a combination of three tools to quickly enumerate subdomains, given a domain. 

First, the script will run the domain through subfinder with \-silent to reduce output and \-nW to remove wildcarded and dead domains from the output.

Second, the script will take the domains found from subfinder and run them through ripgen to create new permutations of the discovered subdomains.

Third, the script will run the domains created by ripgen with \-silent to reduce output and \-t 1000 to increase the number of threads ripgen uses. This tool can take a while depending on the amount of domains passed in by ripgen.

Once completed, the script will combine the subfinder and dnsx outputs into a single file and remove the duplciates. The contents of the file will be printed into the terminal.

The output of each command will be saved off into their own file and saved into a user specified directory in the format *host*_*tool*.txt. If no directory is specified, it will default to the displayed directory. 

## Dependency Installation
1. Install subfinder
    - ```apt install subfinder```
2. Install ripgen
    - ```curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh```
    - ```source $HOME/.cargo/env```
    - ```cargo install ripgen```
3. Install dnsx
    - ```apt install dnsx```

## Individual Tool Documentation
- [Subfinder](https://github.com/projectdiscovery/subfinder) 
- [Ripgen](https://github.com/resyncgg/ripgen)
- [Dnsx](https://github.com/projectdiscovery/dnsx)
