```macos
B64_CONTENT=$(base64 -i main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = atob(\`${B64_CONTENT}\`);#" worker.js
```

```linux
B64_CONTENT=$(base64 -w 0 main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = atob(\`${B64_CONTENT}\`);#" worker.js
```