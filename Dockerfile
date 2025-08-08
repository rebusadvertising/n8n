FROM n8nio/n8n:latest

USER root
# Install globally so n8n can require/import them
RUN npm install -g @portabletext/block-tools @sanity/schema jsdom

USER node
