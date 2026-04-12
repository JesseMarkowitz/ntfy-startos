# NTFY on StartOS

NTFY is a simple HTTP-based pub-sub notification service. Send push
notifications to your phone or desktop via scripts or a REST API.

## Initial Setup

1. Install and start the service.
2. In the service config, set **Base URL** to your public URL (your Tor
   `.onion` address or LAN HTTPS address). This is required for attachment
   links and web push to work correctly.
3. Open the Web Interface (from the Tor address or LAN HTTPS address).
4. Create your first user via the signup form. By default this user is a
   regular (non-admin) user.
5. To promote a user to admin, open a shell into the container and run:

   ```
   ntfy user change-role <username> admin
   ```

6. Once you have an admin, you can disable signup in the service config.

## Configuration

Available in the service config:

- **Enable Signup**: allow new users to register accounts
- **Base URL**: public URL of your server (Tor `.onion` or LAN HTTPS URL)
- **Log Level**: server log verbosity
- **Attachment File Size Limit**: maximum size of a single attachment
- **Attachment Total Size Limit**: maximum total disk usage for attachments
- **Per-Visitor Attachment Limit**: per-visitor attachment quota
- **Cache Duration**: how long messages and attachments are retained

## Usage

Publish a notification:

```
curl -d "Hello from StartOS" https://your-ntfy-address/mytopic
```

Subscribe from the web interface, mobile app, or any HTTP client.
See https://docs.ntfy.sh/ for full documentation.
