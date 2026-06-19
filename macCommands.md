# This is just simply a collection of commands of mac terminal commands for my OS config; 

# Dock speed
 defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -float 0.5; killall Dock

 # Finder Path bar
 defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder

 # Disable folder extension warning
 defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false" && killall Finder

 # Deactivate apple intell
 defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false"
 
