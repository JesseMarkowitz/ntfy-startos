import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
  "signup-enabled": {
    "name": "Enable Signup",
    "description": "Allow new users to create accounts on the server",
    "type": "boolean",
    "default": true,
  },
  "base-url": {
    "name": "Base URL",
    "description":
      "Public URL of your ntfy server (your Tor .onion or LAN HTTPS URL, e.g. https://ntfy.local). Required for attachment links and web push to resolve correctly.",
    "type": "string",
    "nullable": true,
    "masked": false,
    "copyable": false,
  },
  "log-level": {
    "name": "Log Level",
    "description": "Verbosity of server logs",
    "type": "enum",
    "values": ["trace", "debug", "info", "warn", "error"],
    "value-names": {
      "trace": "Trace",
      "debug": "Debug",
      "info": "Info",
      "warn": "Warn",
      "error": "Error",
    },
    "default": "info",
  },
  "attachment-file-size-limit": {
    "name": "Attachment File Size Limit (MB)",
    "description": "Maximum size of a single attachment in megabytes",
    "type": "number",
    "nullable": false,
    "integral": true,
    "range": "[1,1000]",
    "default": 15,
  },
  "attachment-total-size-limit": {
    "name": "Attachment Total Size Limit (MB)",
    "description":
      "Maximum total disk usage for all attachments, in megabytes",
    "type": "number",
    "nullable": false,
    "integral": true,
    "range": "[100,1000000]",
    "default": 5000,
  },
  "visitor-attachment-limit": {
    "name": "Per-Visitor Attachment Limit (MB)",
    "description":
      "Maximum total attachment storage per visitor, in megabytes",
    "type": "number",
    "nullable": false,
    "integral": true,
    "range": "[10,100000]",
    "default": 100,
  },
  "cache-duration": {
    "name": "Cache Duration (hours)",
    "description":
      "How long messages and attachments are retained, in hours",
    "type": "number",
    "nullable": false,
    "integral": true,
    "range": "[1,8760]",
    "default": 12,
  },
});
