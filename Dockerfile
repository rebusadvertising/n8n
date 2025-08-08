FROM n8nio/n8n:latest

USER root

# Install required modules into n8n's own node_modules so require() can find them
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install --omit=dev @portabletext/block-tools @sanity/schema jsdom

USER node
