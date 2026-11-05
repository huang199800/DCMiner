#!/usr/bin/env bash
set -euo pipefail
export TERM=xterm
trap 'cat /tmp/dc-install.log /tmp/dc-cli.log /root/DCMiner/err.log 2>/dev/null || true' ERR
bash -n /src/install.sh
# Use the exact published entry point, not a modified installer.
curl -fLsS --retry 5 "https://raw.githubusercontent.com/huang199800/DCMiner/main/install.sh?verify=$(date +%s)" -o /tmp/public-install.sh
cmp /tmp/public-install.sh /src/install.sh
printf '2\n1\n' | bash /tmp/public-install.sh > /tmp/dc-install.log 2>&1
test -x /root/DCMiner/DCMiner
pgrep -x DCMiner
port=$(sed -n 's/^START_PORT=//p' /root/DCMiner/rust-config)
for i in $(seq 1 30); do
  if curl -fsS "http://127.0.0.1:${port}/" -o /tmp/dc-web.html; then break; fi
  sleep 1
done
test -s /tmp/dc-web.html
printf '%s  %s\n' '20d19d650a545499c0981d7817c523588e2ffaab32f0a433bd8fea983c40159d' /root/DCMiner/DCMiner | sha256sum -c -
# The interactive terminal UI may exit without a TTY; installation must still finish.
set +e
printf '2\n22\n1\n' | timeout 60 bash /tmp/public-install.sh > /tmp/dc-cli.log 2>&1
cli_status=$?
set -e
if [ "$cli_status" -eq 124 ]; then echo 'CLI installation timed out'; exit 1; fi
test -x /usr/local/bin/rustminer
test -x /root/DCMiner/RustMinerSystemCLI-0.1.0
printf '%s  %s\n' '0e086d8369d4f8877a952de25f1eb8d3ca86568fe8e2bc7c30fb7b20d3adcc00' /root/DCMiner/RustMinerSystemCLI-0.1.0 | sha256sum -c -
grep -q '^ENABLE_WEB_UI=0$' /root/DCMiner/rust-config
rustminer stop
! pgrep -x DCMiner
rustminer start
pgrep -x DCMiner
rustminer restart
pgrep -x DCMiner
printf '2\n19\nYES\n' | bash /tmp/public-install.sh > /tmp/dc-uninstall.log 2>&1
test ! -e /root/DCMiner
test ! -e /usr/local/bin/rustminer
! pgrep -x DCMiner
echo 'PASS: public installer, binary hash, startup, Web, CLI installation, stop/start/restart, uninstall'

