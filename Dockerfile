FROM n8nio/n8n:latest

USER root

# Install packages directly into the n8n installation so the task runner's
# require() can resolve them via the normal node_modules hierarchy.
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @portabletext/block-tools @sanity/schema jsdom docx

# Fallback: also make global installs discoverable by the task runner process
ENV NODE_PATH=/usr/local/lib/node_modules/n8n/node_modules:/usr/local/lib/node_modules

USER node
