#!/bin/bash
set -e

DATA_DIR="/data"
CONFIG_FILE="${DATA_DIR}/start9/config.yaml"

SIGNUP_ENABLED="true"
LOG_LEVEL="info"
ATTACHMENT_FILE_LIMIT="15"
ATTACHMENT_TOTAL_LIMIT="5000"
VISITOR_ATTACHMENT_LIMIT="100"
CACHE_DURATION="12"
BASE_URL=""

if [ -f "$CONFIG_FILE" ]; then
    SIGNUP_ENABLED=$(yq e '.signup-enabled // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
    LOG_LEVEL=$(yq e '.log-level // "info"' "$CONFIG_FILE" 2>/dev/null || echo "info")
    ATTACHMENT_FILE_LIMIT=$(yq e '.attachment-file-size-limit // 15' "$CONFIG_FILE" 2>/dev/null || echo "15")
    ATTACHMENT_TOTAL_LIMIT=$(yq e '.attachment-total-size-limit // 5000' "$CONFIG_FILE" 2>/dev/null || echo "5000")
    VISITOR_ATTACHMENT_LIMIT=$(yq e '.visitor-attachment-limit // 100' "$CONFIG_FILE" 2>/dev/null || echo "100")
    CACHE_DURATION=$(yq e '.cache-duration // 12' "$CONFIG_FILE" 2>/dev/null || echo "12")
    BASE_URL=$(yq e '.base-url // ""' "$CONFIG_FILE" 2>/dev/null || echo "")
fi

mkdir -p "${DATA_DIR}/attachments"

export NTFY_LISTEN_HTTP=":80"
export NTFY_CACHE_FILE="${DATA_DIR}/cache.db"
export NTFY_AUTH_FILE="${DATA_DIR}/auth.db"
export NTFY_AUTH_DEFAULT_ACCESS="deny-all"
export NTFY_BEHIND_PROXY="true"
export NTFY_ENABLE_LOGIN="true"
export NTFY_ENABLE_SIGNUP="${SIGNUP_ENABLED}"
export NTFY_ATTACHMENT_CACHE_DIR="${DATA_DIR}/attachments"
export NTFY_ATTACHMENT_FILE_SIZE_LIMIT="${ATTACHMENT_FILE_LIMIT}m"
export NTFY_ATTACHMENT_TOTAL_SIZE_LIMIT="${ATTACHMENT_TOTAL_LIMIT}m"
export NTFY_VISITOR_ATTACHMENT_TOTAL_SIZE_LIMIT="${VISITOR_ATTACHMENT_LIMIT}m"
export NTFY_CACHE_DURATION="${CACHE_DURATION}h"
export NTFY_ATTACHMENT_EXPIRY_DURATION="${CACHE_DURATION}h"
export NTFY_KEEPALIVE_INTERVAL="45s"
export NTFY_LOG_LEVEL="${LOG_LEVEL}"
export NTFY_ENABLE_METRICS="true"

if [ -n "$BASE_URL" ] && [ "$BASE_URL" != "null" ]; then
    export NTFY_BASE_URL="${BASE_URL}"
else
    export NTFY_BASE_URL="http://localhost"
fi

echo "========================================"
echo "NTFY Configuration:"
echo "  Base URL: ${NTFY_BASE_URL:-<auto>}"
echo "  Signup Enabled: ${NTFY_ENABLE_SIGNUP}"
echo "  Log Level: ${NTFY_LOG_LEVEL}"
echo "  Attachment File Limit: ${NTFY_ATTACHMENT_FILE_SIZE_LIMIT}"
echo "  Attachment Total Limit: ${NTFY_ATTACHMENT_TOTAL_SIZE_LIMIT}"
echo "  Cache Duration: ${NTFY_CACHE_DURATION}"
echo "========================================"

exec ntfy serve
