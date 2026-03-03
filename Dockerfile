FROM n8nio/n8n:latest

USER root

# Install modules globally (avoids npm catalog protocol issues in bundled n8n),
# then symlink them into n8n's local node_modules so task-runner require() can
# resolve them without relying only on NODE_PATH.
RUN npm install -g @portabletext/block-tools @sanity/schema jsdom docx && \
    NPM_GLOBAL_ROOT="$(npm root -g)" && \
    mkdir -p /usr/local/lib/node_modules/n8n/node_modules && \
    ln -sfn "${NPM_GLOBAL_ROOT}/@portabletext" /usr/local/lib/node_modules/n8n/node_modules/@portabletext && \
    ln -sfn "${NPM_GLOBAL_ROOT}/@sanity" /usr/local/lib/node_modules/n8n/node_modules/@sanity && \
    ln -sfn "${NPM_GLOBAL_ROOT}/jsdom" /usr/local/lib/node_modules/n8n/node_modules/jsdom && \
    ln -sfn "${NPM_GLOBAL_ROOT}/docx" /usr/local/lib/node_modules/n8n/node_modules/docx

# Fallback: make common global module roots discoverable as well.
ENV NODE_PATH=/usr/local/lib/node_modules/n8n/node_modules:/usr/local/lib/node_modules:/home/node/.npm-global/lib/node_modules

USER node
