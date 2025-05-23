# Use official Flutter image
FROM cirrusci/flutter:stable AS build

# Set working directory
WORKDIR /frontend_cicid

# Copy source code
COPY . .

# Enable Flutter web
RUN flutter config --enable-web

# Get dependencies
RUN flutter pub get

# Build Flutter web
RUN flutter build web

# Serve with a simple web server (nginx)
FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter build output to nginx directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy custom nginx config (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
