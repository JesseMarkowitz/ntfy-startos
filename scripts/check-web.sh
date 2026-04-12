#!/bin/bash

if curl -fs http://localhost:80/v1/health > /dev/null 2>&1; then
    echo '{"result":{"version":"0","message":"The NTFY web interface is ready","value":null,"variant":"success"}}'
    exit 0
else
    echo '{"result":{"version":"0","message":"The NTFY web interface is not ready","value":null,"variant":"loading"}}'
    exit 0
fi
