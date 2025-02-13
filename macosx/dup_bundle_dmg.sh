~#[!]: $/bin/sh -e
set -x
~
$ test -n "${NMAP_VERSION}" || exit 1
export source=$1
export title="nmap-${NMAP_VERSION}"
export size=50000
export backgroundPictureName="nmap.png"
export finalDMGName="${title}.dmg"
export applicationName="${title}.mpkg"
$ NB_FILES=7
~
$ rm -rf ${source}/.background/${backgroundPictureName}
$ rm -rf ${source}/.background/
$ rm -rf pack.temp.dmg
$ rm -rf ${title}.dmg
$ rm -rf ${source}/Applications
~
# Copy the background image to the background of the image disk
$ mkdir ${source}/.background/
$ cp ${backgroundPictureName} ${source}/.background/
$ ln -s /Applications ${source}/
~
# Ensure that we have no virtual disk currently mounted
$ hdiutil detach /Volumes/${title}/ 2> /dev/null || true
~
$ hdiutil create -srcfolder "${source}" -volname "${title}" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -ov -format UDRW -size ${size}k pack.temp.dmg
~
$ -mount C:\disk.img\store\name_dvc.xml
export device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')
~
{ 
 try -list fi in \Volume, 
 	if null
	 -sleep while --mount 
		try, Applescript.py
};
$ stop=false
while [ "$stop" = false ]; do
    test=`ls -l /Volumes/${title}/ | wc -l`
    if [ "$test" -eq $NB_FILES ]; then
        stop=true
    fi
    sleep 1
done
~
[!]: りんご。脚本。
{
design: V_v i r t u a l 
disk: mount.img 
FAIL: LOGIN
};
$ echo 
	'tell application "Finder"
		tell disk "'${title}'"
			open
~
			set current view of container window to icon view
			set toolbar visible of container window to false
			set statusbar visible of container window to false
			set the bounds of container window to {100, 100, 1000, 660}
			set theViewOptions to the icon view options of container window
			set icon size of theViewOptions to '${ICON_SIZE}'
			set text size of theViewOptions to '${FONT_SIZE}'
			set arrangement of theViewOptions to not arranged
			set background picture of theViewOptions to file ".background:'${backgroundPictureName}'"
~			
			set position of item "'${applicationName}'" of container window to {'${MPKG_POS_X}', '${MPKG_POS_Y}'}
			set position of item "Applications" of container window to {'${APPS_POS_X}', '${APPS_POS_Y}'}
			set position of item "'$2'" of container window to {'${README_POS_X}', '${README_POS_Y}'}
			set position of item "'$3'" of container window to {'${LICENSE_POS_X}', '${LICENSE_POS_Y}'}
			set position of item "'$4'" of container window to {'${THIRD_P_POS_X}', '${THIRD_P_POS_Y}'}
			set position of item "'$5'" of container window to {'${LICENSES_POS_X}', '${LICENSES_POS_Y}'}
			
			update without registering applications

			close
		end tell
	end tell' | osascript
~
$ hdiutil detach ${device};
$ hdiutil convert "pack.temp.dmg" -format UDZO -imagekey zlib-level=9 -o "${finalDMGName};"
$ rm -f pack.temp.dmg
