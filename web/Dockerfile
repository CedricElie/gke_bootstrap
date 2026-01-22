FROM nginx:latest

# Copy the HTML page to nginx default serve directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
