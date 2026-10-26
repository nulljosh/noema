# Security

Report vulnerabilities privately through GitHub's security advisory flow. Do not post credentials or private genomes in issues.

The first release reads local annotated sequences and optionally sends derived sequence reports to Claude. Revising also sends the prior hypothesis and attached observations. The browser landing page uses only bundled public results. It has no upload endpoint or AI endpoint.

Treat GenBank files and observation text as untrusted input. AI has no tools or MCP access. A hypothesis is text, never executable instructions. Notebook entries are user-reported and unverified; model output needs review. No clinical decision support or hardware control exists in this release.
