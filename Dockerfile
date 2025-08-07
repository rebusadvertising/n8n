# Dockerfile for n8n with HTML to Portable Text conversion support
# This extends the official n8n image with required packages for Code nodes

FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install packages needed for HTML to Portable Text conversion
# - @portabletext/block-tools: Convert HTML to Sanity Portable Text blocks
# - @sanity/schema: Schema compilation for proper block structure
# - jsdom: HTML parsing in Node.js environment
RUN npm install -g \
    @portabletext/block-tools \
    @sanity/schema \
    jsdom

# Switch back to node user for security
USER node

# The rest inherits from the base n8n image:
# - EXPOSE 5678/tcp
# - ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
# - WORKDIR /home/node

# Usage:
# 1. Set environment variable: NODE_FUNCTION_ALLOW_EXTERNAL=@portabletext/block-tools,@sanity/schema,jsdom
# 2. In n8n Code nodes, you can now require these packages:
#    const { htmlToBlocks } = require('@portabletext/block-tools');
#    const Schema = require('@sanity/schema').default;
#    const { JSDOM } = require('jsdom');
