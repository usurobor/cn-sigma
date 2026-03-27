# Pi Deployment Procedure

**Date:** 2026-03-27
**Type:** adhoc / operational reference

## Pi VPS

- Host: 143.198.14.19
- User: root
- Hub: /home/cn/cn-pi
- Arch: x86_64 (linux-x64)
- Binary: /usr/local/bin/cn

## Deployment steps

1. CI Release workflow builds binaries for all platforms on tag push
2. Download from GH release: `gh release download <version> --repo usurobor/cnos --pattern 'cn-linux-x64'`
3. SCP to Pi: `scp cn-linux-x64 root@143.198.14.19:/usr/local/bin/cn.new`
4. On Pi: `chmod +x /usr/local/bin/cn.new && mv /usr/local/bin/cn.new /usr/local/bin/cn`
5. Restart daemon (if running): `systemctl restart cn-daemon` or manual restart
6. Verify: `cn --version`

## Current state (2026-03-27)

- Binary: 3.22.0 (70652a7)
- Daemon: not running (no systemd service found, no process)
- RC reports: 3.16.1 (stale — from last daemon run)
