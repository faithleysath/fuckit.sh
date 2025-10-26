# Deployment

To deploy the worker to Cloudflare, simply run:

```bash
wrangler deploy
```

That's it. The `wrangler.toml` is configured to automatically include `main.sh` and `zh_main.sh` in the build.
