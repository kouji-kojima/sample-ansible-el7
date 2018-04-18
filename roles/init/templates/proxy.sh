PROXY={{ http_proxy }}
export http_proxy=$PROXY
export https_proxy=$PROXY
export ftp_proxy=$PROXY
export HTTP_PROXY=$PROXY
export HTTPS_PROXY=$PROXY
export FTP_PROXY=$PROXY

export no_proxy=localhost,127.0.0.0/8,{{ no_proxys }}
export NO_PROXY=$no_proxy
