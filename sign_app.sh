#!/bin/bash
APP_PATH="/path/to/YourApp.app"
KEXT_PATH="/path/to/YourKernelExt.kext"
CERTIFICATE="Developer ID Application: Your (Company's) cert"
KEXT_CERTIFICATE="Developer ID Application: Your (Company's) Certificate for Signing Kexts"

#sign (verify if cert is not expired, kill when invalid, sign nested content)
codesign --sign="$CERTIFICATE" --verbose --force --options=kill,expires --deep "$APP_PATH"
echo "Signing '$APP_PATH' with codesign: return = $?"

# #verify
codesign -dvvv "$APP_PATH"

# #sign kernel extension. You need to request a special Developer ID Certificate for Signing Kexts
codesign --sign="$KEXT_CERTIFICATE" --verbose --force --options=kill,expires "$KEXT_PATH"
echo "Signing '$KEXT_PATH' with codesign: return = $?"
		
#verify
codesign -dvvv "$KEXT_PATH"
