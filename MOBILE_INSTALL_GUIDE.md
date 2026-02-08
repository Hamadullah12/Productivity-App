# 📱 Install Project Focus on Your Mobile Phone

## Method 1: Build APK & Install (Easiest!)

### Step 1: Build the APK File

Open PowerShell and run:

```powershell
cd "d:\PRODUCTIVITY APP"
C:\flutter\bin\flutter.bat build apk --release
```

This will take 3-5 minutes. Wait for "Built build\app\outputs\flutter-apk\app-release.apk" message.

### Step 2: Find Your APK

The APK file will be at:
```
d:\PRODUCTIVITY APP\build\app\outputs\flutter-apk\app-release.apk
```

### Step 3: Transfer to Phone

**Option A: USB Cable**
1. Connect your phone to PC with USB cable
2. Copy `app-release.apk` to your phone (Downloads folder)
3. On your phone, go to Files/Downloads
4. Tap `app-release.apk`
5. Allow installation from unknown sources if prompted
6. Tap "Install"

**Option B: Google Drive / WhatsApp**
1. Upload `app-release.apk` to Google Drive
2. Download on your phone
3. Tap the file and install

**Option C: Bluetooth**
1. Send `app-release.apk` via Bluetooth to your phone
2. Accept the file
3. Tap to install

### Step 4: Allow Unknown Sources

If you get "Installation blocked" message:
1. Go to Settings → Security
2. Enable "Install from Unknown Sources"
3. Or tap "Settings" in the popup and enable for that specific app

### Step 5: Enjoy!

Open "Project Focus" app from your app drawer! 🎉

---

## Method 2: Run Directly on Phone (For Developers)

### Requirements:
- USB Cable
- Developer Options enabled on phone

### Step 1: Enable Developer Options on Phone

1. Go to Settings → About Phone
2. Tap "Build Number" 7 times
3. You'll see "You are now a developer!"

### Step 2: Enable USB Debugging

1. Go to Settings → System → Developer Options
2. Turn on "USB Debugging"

### Step 3: Connect Phone to PC

1. Connect phone via USB cable
2. On phone, allow "USB Debugging" permission
3. Select "File Transfer" mode (not "Charging only")

### Step 4: Verify Phone is Detected

```powershell
cd "d:\PRODUCTIVITY APP"
C:\flutter\bin\flutter.bat devices
```

You should see your phone listed!

### Step 5: Run App on Phone

```powershell
C:\flutter\bin\flutter.bat run
```

The app will install and run directly on your phone!

---

## Method 3: Wireless Debugging (Android 11+)

If your phone has Android 11 or later:

1. Go to Settings → Developer Options
2. Enable "Wireless Debugging"
3. Tap "Pair device with pairing code"
4. On PC, run:
   ```powershell
   adb pair <IP:PORT>
   ```
   (Use the IP and port shown on phone)
5. Enter the pairing code
6. Run the app:
   ```powershell
   C:\flutter\bin\flutter.bat run
   ```

---

## 🔧 Troubleshooting

### "Installation blocked"
- Enable "Install from Unknown Sources" in Settings → Security

### "App not installed"
- Make sure you have enough storage
- Try uninstalling old version first
- Restart phone and try again

### Phone not detected (Method 2)
- Make sure USB debugging is enabled
- Try different USB cable
- Install phone drivers (manufacturer website)
- On PC, you may need to install Android SDK Platform Tools

### Build errors
- Run: `C:\flutter\bin\flutter.bat clean`
- Then: `C:\flutter\bin\flutter.bat pub get`
- Try building again

---

## 📊 File Sizes

- APK file: ~25-40 MB
- Installed app: ~50-70 MB
- Storage space needed: ~100 MB recommended

---

## 🎯 Recommended Method

**For most users**: Use **Method 1** (Build APK)
- No USB cable needed
- Easy to share with friends
- Works on any Android phone
- One-time installation

---

## ✅ Next Steps After Installation

1. Open the app
2. Complete onboarding (name, university, etc.)
3. Allow notifications when prompted
4. Start tracking your tasks!

---

**Need help?** The app works best on Android 5.0 (API 21) or higher.

Good luck! 🚀📱
