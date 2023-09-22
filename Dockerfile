# Build Phase

# Name of the build stage. Everything under "as builder" will be part of one phase
FROM node:18-alpine as builder  

WORKDIR '/app'

COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# To specify the 2nd phase, all we have to do is write "From" and specify the image
# From statement are terminating each previous block
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# I want to copy something from the builder phase
# Copy from /app/build to 

# We don't have to explicilty start up nginx. When we start up
# nginx container, it will automatically take care of command