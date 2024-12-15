FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Set environment variable for legacy OpenSSL provider
ENV NODE_OPTIONS=--openssl-legacy-provider

# Copy package.json and package-lock.json first (to cache dependencies)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Expose the port the app will run on
EXPOSE 3000

# Serve the build using a static server
RUN npm install -g serve
CMD ["serve", "-s", "build"]
