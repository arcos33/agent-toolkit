# CopyOnSelect on macOS

Use this guide on each MacBook where selecting text with the mouse should copy it automatically. The working setup uses the open-source [`copy-on-select`](https://github.com/yauyauyauhen/copy-on-select) utility, not an Automator Quick Action.

An Automator Quick Action can copy selected text only when manually invoked. It cannot detect when a mouse selection ends.

## What gets installed

| Item | Location |
|---|---|
| Source checkout | `~/projects/copy-on-select` |
| App | `~/Applications/CopyOnSelect.app` |
| Login launcher | `~/Library/LaunchAgents/dev.copy-on-select.plist` |
| Signing identity | Login keychain certificate named `copy-on-select-local` |

CopyOnSelect requires Accessibility permission. It does not require Input Monitoring.

## 1. Build from source

Requirements: macOS 13 or newer and Swift 6.1 or newer.

```bash
swift --version
sw_vers -productVersion
mkdir -p ~/projects
git clone https://github.com/yauyauyauhen/copy-on-select.git ~/projects/copy-on-select
cd ~/projects/copy-on-select
swift build -c release
test -x .build/release/copy-on-select && echo "built ok"
```

If the repository already exists, update it instead:

```bash
cd ~/projects/copy-on-select
git pull --ff-only
swift build -c release
```

## 2. Create the stable signing certificate

This is a one-time setup on each Mac. A stable certificate prevents macOS from forgetting the Accessibility grant after a rebuild.

Open **Keychain Access → Certificate Assistant → Create a Certificate…** and use these values:

1. **Create Your Certificate**
   - Name: `copy-on-select-local`
   - Identity Type: **Self Signed Root**
   - Certificate Type: **Code Signing**
   - Enable **Let me override defaults**.
2. **Certificate Information**
   - Serial Number: `1`
   - Validity Period: `7300` days.
3. **Personal information**
   - Clear the Email Address field.
   - Keep the common name `copy-on-select-local`.
   - Leave Organization, Organizational Unit, City, and State blank.
4. **Key Pair Information**
   - Key Size: **2048 bits**
   - Algorithm: **RSA**.
5. **Key Usage Extension**
   - Keep the extension enabled.
   - Select only **Signature**.
6. **Extended Key Usage Extension**
   - Keep the extension enabled.
   - Select only **Code Signing**.
7. **Basic Constraints Extension**
   - Leave it disabled.
8. **Subject Alternate Name Extension**
   - Disable it and leave every field blank.
9. **Certificate location**
   - Select the **login** keychain and create the certificate.

The final warning that the certificate is not verified by a third party is expected for a local self-signed certificate.

Verify it:

```bash
security find-certificate -c copy-on-select-local >/dev/null 2>&1 \
  && echo "certificate exists"
```

## 3. Assemble and sign the app

```bash
cd ~/projects/copy-on-select
mkdir -p ~/Applications/CopyOnSelect.app/Contents/MacOS
cp .build/release/copy-on-select \
  ~/Applications/CopyOnSelect.app/Contents/MacOS/CopyOnSelect
```

Create `~/Applications/CopyOnSelect.app/Contents/Info.plist` with:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key><string>dev.copy-on-select</string>
    <key>CFBundleName</key><string>CopyOnSelect</string>
    <key>CFBundleExecutable</key><string>CopyOnSelect</string>
    <key>CFBundleShortVersionString</key><string>0.1.0</string>
    <key>CFBundleVersion</key><string>1</string>
    <key>CFBundlePackageType</key><string>APPL</string>
    <key>LSUIElement</key><true/>
    <key>LSMinimumSystemVersion</key><string>13.0</string>
</dict>
</plist>
```

Sign and verify:

```bash
plutil -lint ~/Applications/CopyOnSelect.app/Contents/Info.plist
codesign --force --deep --sign copy-on-select-local \
  ~/Applications/CopyOnSelect.app
codesign --verify --strict ~/Applications/CopyOnSelect.app \
  && echo "signature valid"
```

If Keychain asks whether `codesign` may use the private key, choose **Always Allow**.

Never re-sign this app with a different identity. macOS binds its Accessibility permission to the signature and installation path.

## 4. Grant Accessibility

Register and launch the app:

```bash
open ~/Applications/CopyOnSelect.app
```

Open **System Settings → Privacy & Security → Accessibility** and turn on **CopyOnSelect.app**. If it is missing:

1. Click **+**.
2. Press **Command-Shift-G**.
3. Enter `~/Applications`.
4. Select `CopyOnSelect.app`.

Decline Input Monitoring if macOS offers it. After enabling Accessibility, restart CopyOnSelect before testing.

## 5. Start automatically at login

Create `~/Library/LaunchAgents/dev.copy-on-select.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>dev.copy-on-select</string>
    <key>ProgramArguments</key>
    <array>
        <string>REPLACE_WITH_HOME/Applications/CopyOnSelect.app/Contents/MacOS/CopyOnSelect</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>ProcessType</key>
    <string>Interactive</string>
</dict>
</plist>
```

Replace `REPLACE_WITH_HOME` with the full home path on that Mac, such as `/Users/samantha`. LaunchAgent files do not expand `~` or `$HOME` inside `ProgramArguments`.

Then load it:

```bash
pkill -f "CopyOnSelect.app/Contents/MacOS/CopyOnSelect" 2>/dev/null
launchctl unload ~/Library/LaunchAgents/dev.copy-on-select.plist 2>/dev/null
launchctl load ~/Library/LaunchAgents/dev.copy-on-select.plist
launchctl list | grep dev.copy-on-select
```

Verify the complete setup:

```bash
~/Applications/CopyOnSelect.app/Contents/MacOS/CopyOnSelect --check
```

## 6. End-to-end test

1. Open TextEdit and type a unique sentence.
2. Select it with the mouse without pressing Command-C.
3. Run `pbpaste`; it must print that sentence.
4. In Finder, click-hold a file, move it slightly, and release it in the same place.
5. Run `pbpaste` again; it must still print the sentence. Finder file drags must not overwrite the clipboard.

## Daily use

- Mouse-drag selections and double- or triple-click selections copy automatically.
- Finder and common terminals/editors are excluded by default for safety.
- The menu bar icon provides **Pause**, **Reveal Config…**, and **Quit**.
- A warning icon means Accessibility was revoked or the event listener stopped.

## Updating

Always rebuild and sign with the same `copy-on-select-local` identity:

```bash
cd ~/projects/copy-on-select
git pull --ff-only
swift build -c release
launchctl unload ~/Library/LaunchAgents/dev.copy-on-select.plist
cp .build/release/copy-on-select \
  ~/Applications/CopyOnSelect.app/Contents/MacOS/CopyOnSelect
codesign --force --deep --sign copy-on-select-local \
  ~/Applications/CopyOnSelect.app
codesign --verify --strict ~/Applications/CopyOnSelect.app
launchctl load ~/Library/LaunchAgents/dev.copy-on-select.plist
```

Do not change the app path or signing identity during an update.

## Troubleshooting

If the menu icon shows a warning or selections stop copying:

1. Confirm **CopyOnSelect.app** is on under Accessibility.
2. Toggle it off and on if necessary.
3. Restart the background process:

   ```bash
   launchctl unload ~/Library/LaunchAgents/dev.copy-on-select.plist
   launchctl load ~/Library/LaunchAgents/dev.copy-on-select.plist
   ```

4. Repeat the TextEdit test.

For damaged or stale Accessibility records, follow the upstream [`TROUBLESHOOTING.md`](https://github.com/yauyauyauhen/copy-on-select/blob/main/TROUBLESHOOTING.md). The authoritative installation instructions are upstream in [`install.md`](https://github.com/yauyauyauhen/copy-on-select/blob/main/install.md).
