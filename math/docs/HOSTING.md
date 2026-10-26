# Hosting

Public domain: https://noema.jaybulb.com. Deployed through the Sites plugin, with source identity in .openai/hosting.json. Static source is landing/; the package preparation command copies it into ignored dist/. Git pushes alone are not treated as successful deployments.

Cloudflare zone jaybulb.com has a DNS-only noema CNAME to the target returned by Sites, with TXT ownership-validation records. Site audience is public at Joshua's request. HTTPS and hostname activation were checked on October 14, 2026. The current custom-domain identifier is appgdom_6acfb6bf60188191bb21518bbddd7d92.

Keep short-lived source credentials in session memory and send them to the Sites helper over stdin. Never save tokens in this repository. Update source, run checks, package from the pushed commit, save the version, deploy, then verify the returned state.
