This is a fork of https://github.com/rdvencioneck/aws-vpn-client-docker meant to work on modern Linux.

# Usage
Clone this repository.  

Build the Docker image:  
`docker build -t aws-vpn-client-docker .`

Start the container:  
`./aws-vpn-client-docker <vpn-config-file-path>`  
It should display a link you can CTRL+click on to authenticate, start Openvpn with the gathered credentials and you should be connected.  