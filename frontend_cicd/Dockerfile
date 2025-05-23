# Use official Flutter image
FROM cirrusci/flutter:stable AS build

# Enable web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy app code
COPY . /app
WORKDIR /app

# Get dependencies and build web app
RUN flutter pub get
RUN flutter build web

# Stage for serving with nginx
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built Flutter web app
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
