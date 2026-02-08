# 🔧 Flutter Installation Guide for Windows

## Prerequisites Check

Before running the Project Focus app, you need to have Flutter installed on your system.

---

## Method 1: Install Flutter (Recommended)

### Step 1: Download Flutter SDK

1. Visit: https://docs.flutter.dev/get-started/install/windows
2. Download the latest stable Flutter SDK (ZIP file)
3. Extract to `C:\src\flutter` (or any location without spaces)

### Step 2: Add Flutter to PATH

1. Search for "Environment Variables" in Windows Start menu
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", find `Path` and click "Edit"
5. Click "New" and add: `C:\src\flutter\bin` (or your installation path)
6. Click "OK" on all windows

### Step 3: Verify Installation

Open a **new** PowerShell/CMD window:

```bash
flutter --version
flutter doctor
```

### Step 4: Install Additional Dependencies

Flutter Doctor will show what's missing. Common requirements:

#### For Android Development:
1. **Android Studio**: Download from https://developer.android.com/studio
2. Install Android SDK (Flutter doctor will guide you)
3. Create an Android Virtual Device (AVD) in Android Studio

#### For Web Development (Easiest!):
1. **Chrome Browser**: Already installed for most users
2. Enable web support:
   ```bash
   flutter config --enable-web
   ```

#### For Windows Desktop:
1. **Visual Studio 2022**: Download Community edition
2. Install "Desktop development with C++" workload

### Step 5: Run Flutter Doctor

```bash
flutter doctor -v
```

Fix any issues shown (Flutter will provide guidance).

---

## Method 2: Use Online Flutter Environment (No Installation!)

If you don't want to install Flutter locally, you can use:

### DartPad
- Visit: https://dartpad.dev/
- Limited functionality, but can run simple Flutter apps

### Zapp
- Visit: https://zapp.run/
- Full Flutter environment in the browser
- Upload the project files

---

## After Flutter Installation: Run Project Focus

Once Flutter is installed:

```bash
cd "d:\PRODUCTIVITY APP"
flutter pub get
flutter run -d chrome
```

---

## Troubleshooting Flutter Installation

### Error: "flutter: command not found"
**Solution**: 
- Restart your terminal/PowerShell
- Ensure Flutter is in your PATH (see Step 2 above)
- Try running from a new terminal window

### Error: "Android licenses not accepted"
**Solution**:
```bash
flutter doctor --android-licenses
```
Accept all licenses by typing 'y'

### Error: "No devices found"
**Solutions**:
- For Web: Run `flutter run -d chrome`
- For Android: Start an emulator from Android Studio
- For Windows: No emulator needed, just run `flutter run -d windows`

---

## Minimum System Requirements

- **OS**: Windows 10 or later (64-bit)
- **Disk Space**: 2.5 GB (for Flutter SDK, not including IDE)
- **RAM**: 4 GB minimum, 8 GB recommended
- **Tools**: PowerShell or Command Prompt

---

## Quick Test to Verify Flutter

After installation, run this command:

```bash
flutter doctor -v
```

You should see something like:

```
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows...)
[✓] Android toolchain - develop for Android devices
[✓] Chrome - develop for the web
[✓] Visual Studio - develop Windows apps
[✓] Connected device (2 available)
[✓] Network resources
```

You need at least ONE checkmark under devices (Chrome is the easiest!).

---

## Alternative: Use Flutter on Another Machine

If you can't install Flutter on this PC:

1. **Use a Friend's Computer** with Flutter installed
2. **Use University Lab Computers** (they may have Flutter)
3. **Use GitHub Codespaces** (cloud development environment)
4. **Use Gitpod** (another cloud IDE)

Just copy the entire `d:\PRODUCTIVITY APP` folder to that machine and run:
```bash
flutter pub get
flutter run
```

---

## Next Steps

After Flutter is installed and working:

1. ✅ See `QUICKSTART.md` for running the app
2. ✅ See `README.md` for detailed features and usage
3. ✅ Run `flutter doctor` to ensure everything is set up
4. ✅ Start the app with `flutter run -d chrome` (easiest!)

---

## Contact & Support

### Official Flutter Resources:
- Documentation: https://docs.flutter.dev/
- Installation Guide: https://docs.flutter.dev/get-started/install
- Troubleshooting: https://docs.flutter.dev/testing/debugging
- Community: https://flutter.dev/community

### For This Project:
- Check `README.md` for app-specific help
- Check `QUICKSTART.md` for running instructions
- All code is commented for easy understanding

---

**Important**: You MUST have Flutter installed before running this app. Follow the steps above carefully!

Good luck! 🚀
