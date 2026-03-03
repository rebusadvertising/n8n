FROM n8nio/n8n:latest

USER root

# Install modules globally to avoid npm catalog protocol issues in bundled n8n.
RUN npm install -g @portabletext/block-tools @sanity/schema jsdom docx

# Fallback: also make global installs discoverable by the task runner process
ENV NODE_PATH=/usr/local/lib/node_modules

USER node
