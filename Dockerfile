# Stage 1: Build the Angular application
FROM node:latest as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --configuration production

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/demo/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]