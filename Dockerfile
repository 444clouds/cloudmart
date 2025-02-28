FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ENV PORT=5001
ENV NODE_ENV=production
ENV VITE_API_BASE_URL=http://ae157e27ae2c44a13a9bc1d8747176d4-1461101211.us-east-1.elb.amazonaws.com:5000/api
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"]


