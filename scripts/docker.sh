#!/bin/bash

sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker

sudo service docker start
docker login --username xxx --password xxx
docker pull broadinstitute/gatk:4.1.3.0
docker run -v ~/path:/gatk/vcf -it broadinstitute/gatk:4.1.3.0
