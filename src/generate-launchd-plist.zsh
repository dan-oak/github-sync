#!/usr/bin/env zsh

wd=$(realpath ${0:a:h}/..)

label=dev.danoak.github-sync.plist
plist_f=~/Library/LaunchAgents/$label

cat <<EOF >$plist_f
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>

    <key>Label</key>
    <string>$label</string>

    <key>RunAtLoad</key>
    <false/>

    <key>KeepAlive</key>
    <true/>

    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key><integer>20</integer>
        <key>Minute</key><integer>0</integer>
    </dict>

    <key>StandardErrorPath</key>
    <string>$wd/github-sync.log</string>

    <key>StandardOutPath</key>
    <string>$wd/github-sync.log</string>

    <key>WorkingDirectory</key>
    <string>$wd</string>

    <key>ProgramArguments</key>
    <array>
      <string>zsh</string>
      <string>github-sync</string>
    </array>

    <key>EnvironmentVariables</key>
    <dict>
    
      <key>PATH</key>
      <string><![CDATA[/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin]]></string>
      
      <key>TERM</key>
      <string>xterm</string>
    
    </dict>

  </dict>
</plist>
EOF
