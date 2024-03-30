#!/bin/bash
# shx Standard Utility
echo "[1;37mGit Commit Signing[0m"
echo "Below is a list of locally available keys."
printf "\n"
gpg --list-secret-keys --keyid-format=long
echo "Please select a key for you to sign commits. Leave it blank to stop signing."
read -p "Key ID (without type): " keyId
if [ "$keyId" == "" ]; then
	git config --unset user.signingkey
	git config commit.gpgsign false
	echo "Future commits will no longer be signed."
else
	git config user.signingkey "$keyId"
	git config commit.gpgsign true
	echo "Future commits will be signed with ${keyId}."
fi
exit