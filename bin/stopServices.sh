#!/bin/sh
#You need to use the launchctl command as follows:
#Disable Cups 2.0
if [ "$(grep "Sandboxing Off" /etc/cups/cups-files.conf)" = "" ]; then
    sudo sh -c 'echo "Sandboxing Off" | sudo tee -a /etc/cups/cups-files.conf > /dev/null'
fi

#Disable notification center, with these 2 commands:
sudo defaults write com.apple.notificationcenterui KeepAlive -bool false
sudo killall NotificationCenter

# https://www.mutface.com/wp-content/cache/all/speed-up-mojave-mac-os-technical-guide/index.html
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock launchanim -bool false
sudo sysctl debug.lowpri_throttle_enabled=0

# Disable all unnecessary system daemons
sudo launchctl stop /System/Library/LaunchAgents/com.apple.SoftwareUpdateNotificationManager.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.apsd.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.mobiledeviceupdater.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.soagent.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.spindump.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.tailspind.plist

launchctl stop /System/Library/LaunchAgents/com.apple.AddressBook.abd.plist
launchctl stop /System/Library/LaunchAgents/com.apple.CalendarAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.CallHistoryPluginHelper.plist
launchctl stop /System/Library/LaunchAgents/com.apple.DiagnosticReportCleanup.plist
launchctl stop /System/Library/LaunchAgents/com.apple.ReportPanic.plist
launchctl stop /System/Library/LaunchAgents/com.apple.ReportCrash.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SocialPushAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.TrustEvaluationAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.ap.adprivacyd.plist
launchctl stop /System/Library/LaunchAgents/com.apple.appstoreagent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.cloudphotod.plist
launchctl stop /System/Library/LaunchAgents/com.apple.familycircled.plist
#Disable imclient (Facetime)
launchctl stop /System/Library/LaunchAgents/com.apple.imagent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.helpd.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.photoanalysisd.plist
sudo launchctl stop /System/Library/LaunchAgents/com.apple.photolibraryd.plist
launchctl stop /System/Library/LaunchAgents/com.apple.screensharing.MessagesAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.sharingd.plist
launchctl stop /System/Library/LaunchAgents/com.apple.siriknowledged.plist

# Disable all unnecessary system agents

# Disable all safari
launchctl stop /System/Library/LaunchAgents/com.apple.Safari.SafeBrowsing.Service.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariBookmarksSyncAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariCloudHistoryPushAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariHistoryServiceAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariLaunchAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariNotificationAgent.plist
launchctl stop /System/Library/LaunchAgents/com.apple.SafariPlugInUpdateNotifier.plist

# Disable all Kerberos
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.Kerberos.digest-service.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.Kerberos.kadmind.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.Kerberos.kcm.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.Kerberos.kdc.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.Kerberos.kpasswdd.plist

# Disable all Games
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.GameController.gamecontrollerd.plist

# Disable all msrpc
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.netbiosd.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.echosvc.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.lsarpc.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.mdssvc.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.netlogon.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.srvsvc.plist
sudo launchctl stop /System/Library/LaunchDaemons/com.apple.msrpc.wkssvc.plist

# disable Game Center daemon
defaults write com.apple.gamed Disabled -bool true
