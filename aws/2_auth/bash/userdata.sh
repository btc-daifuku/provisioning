#!/bin/bash

# set target ecs cluster
cat << EOT >> /etc/ecs/ecs.config
ECS_CLUSTER=daifuku-auth
EOT
