```macos
B64_CONTENT=$(base64 -i main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_CONTENT}\`);#" worker.js
```

```linux
B64_CONTENT=$(base64 -w 0 main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_CONTENT}\`);#" worker.js
```

---

### Chinese Version

```macos
B64_CONTENT=$(base64 -i zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_CONTENT}\`);#" worker.js
```

```linux
B64_CONTENT=$(base64 -w 0 zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_CONTENT}\`);#" worker.js
```

---

### All-in-One Build Command

```macos
B64_EN=$(base64 -i main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_EN}\`);#" worker.js && B64_ZH=$(base64 -i zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_ZH}\`);#" worker.js
```

```linux
B64_EN=$(base64 -w 0 main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_EN}\`);#" worker.js && B64_ZH=$(base64 -w 0 zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_ZH}\`);#" worker.js
```
