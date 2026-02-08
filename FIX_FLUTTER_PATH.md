# 🔧 Fix: Add Flutter to Windows PATH

## Issue
Flutter is installed but PowerShell can't find it. You need to add Flutter to your system PATH.

## Solution (Step-by-Step)

### Method 1: Using Windows Settings (Recommended)

1. **Find Your Flutter Location**
   - Most common locations:
     - `C:\flutter\bin`
     - `C:\src\flutter\bin`
   - Open File Explorer and verify the folder exists

2. **Add to PATH**
   - Press `Windows Key` and search for **"Environment Variables"**
   - Click **"Edit the system environment variables"**
   - Click **"Environment Variables"** button
   - Under **"User variables"**, find **"Path"** and click **"Edit"**
   - Click **"New"**
   - Add your Flutter bin path (e.g., `C:\flutter\bin`)
   - Click **"OK"** on all windows

3. **Restart PowerShell**
   - Close ALL PowerShell/Command Prompt windows
   - Open a NEW PowerShell window
   - Try: `flutter --version`

### Method 2: Quick Test (Temporary - This Session Only)

If you want to test immediately without changing PATH permanently:

```powershell
# Replace with your actual Flutter location
$env:Path += ";C:\flutter\bin"

# Now try
flutter --version
```

### Method 3: Use Full Path (No PATH Change Needed)

You can run Flutter using the full path:

```powershell
# Replace C:\flutter with your actual location
C:\flutter\bin\flutter --version
C:\flutter\bin\flutter pub get
C:\flutter\bin\flutter run -d chrome
```

---

## After PATH is Fixed

Once Flutter is in your PATH, run these commands:

```bash
# 1. Verify Flutter works
flutter --version
flutter doctor

# 2. Navigate to project
cd "d:\PRODUCTIVITY APP"

# 3. Get dependencies
flutter pub get

# 4. Check available devices
flutter devices

# 5. Run the app!
flutter run -d chrome    # Run in Chrome browser
# OR
flutter run              # Run on default device
```

---

## Don't See Flutter Folder?

### If you used the installer:
Flutter might be in:
- `C:\Users\YourName\flutter`
- `C:\Program Files\flutter`
- `C:\tools\flutter`

### To find it:
1. Open File Explorer
2. Search for "flutter" in C drive
3. Look for a folder containing `bin`, `packages`, etc.
4. Use that path + `\bin` in your PATH

---

## Quick Verification

After adding to PATH and restarting PowerShell:

```powershell
# This should show Flutter version
flutter --version

# This should show system status
flutter doctor
```

If both work, you're ready to run the app! 🎉

---

## Alternative: Use Full Path Method

If you don't want to modify PATH, you can use Method 3 above with the full path to Flutter.

Example:
```powershell
cd "d:\PRODUCTIVITY APP"
C:\flutter\bin\flutter pub get
C:\flutter\bin\flutter run -d chrome
```

Just replace `C:\flutter` with wherever you installed Flutter.

---

**Once this is done, come back and we'll run the app!** 🚀
