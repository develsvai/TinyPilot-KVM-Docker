# Base image from Tailscale
FROM tailscale/tailscale:latest

# Install nginx
RUN apk add --no-cache nginx

# Remove default nginx config
RUN rm /etc/nginx/http.d/default.conf

# Copy our custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY tailscale_tinypilot_nginx_proxy.conf /etc/nginx/conf.d/tailscale_tinypilot_nginx_proxy.conf

# Copy and set permissions for the startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Command to run when the container starts
CMD ["/start.sh"]
