# 🔒 SECURITY ALERT & FIX INSTRUCTIONS

## ⚠️ Issue Found & Fixed

Your **Firebase API Key** was committed to the git repository:
- **File:** `android/app/google-services (1).json`
- **Exposed Key:** `AIzaSyBgsFOsM4uuRqSIJ5lgm8_R9IHQPvZ-FtI`

## ✅ Immediate Actions Taken

1. ✅ Updated `.gitignore` to prevent future commits of Firebase files
2. ✅ Created `.env.example` template for configuration
3. ✅ Updated `android/.gitignore` to exclude `google-services.json`

## 🚨 CRITICAL: You Must Do These Steps NOW

### Step 1: Revoke the Exposed API Key
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Navigate to your project: **voidvault-1a67e**
3. Go to **Project Settings → Service Accounts**
4. Regenerate API keys / revoke the exposed key
5. Download the new `google-services.json`

### Step 2: Remove File from Git History
```powershell
# Remove file from git history (keeps local copy)
git rm --cached "android/app/google-services (1).json"

# If you haven't already, remove all firebase config files from git
git rm --cached "android/app/google-services.json"
git rm --cached "ios/GoogleService-Info.plist"

# Commit the removal
git add .
git commit -m "chore: remove sensitive Firebase credentials from git"

# Push to remote
git push -u origin main
```

### Step 3: Clean Git History (Recommended)
This removes the file completely from remote history:
```powershell
# Install git-filter-repo if not already installed
pip install git-filter-repo

# Remove file from all history
git filter-repo --path "android/app/google-services (1).json" --invert-paths

# Force push (⚠️ This rewrites history)
git push origin --force-all
```

### Step 4: Create Local Environment Files (Don't Commit)
1. Copy `.env.example` to `.env` locally (do NOT commit)
2. Download your new `google-services.json` from Firebase Console
3. Place in `android/app/google-services.json` (will be ignored by git)

### Step 5: Update Your CI/CD (if applicable)
If using GitHub Actions or other CI/CD:
- Add Firebase credentials as **secrets** (not in code)
- Use environment variables to pass credentials to build

## 📋 Setup Instructions Going Forward

### For Local Development:
```bash
# Clone repository
git clone <your-repo-url>
cd void_vault

# Create local .env file from template
cp .env.example .env

# Add your Firebase credentials to .env locally
# (This file is .gitignored and won't be committed)
```

### For Firebase Configuration:
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/google-services.json`
3. This file is now gitignored - won't be pushed

### Using Environment Variables in CODE (Optional):
```dart
// example_config.dart
class FirebaseConfig {
  static const String apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
}

// Build with: flutter run --dart-define=FIREBASE_API_KEY=your_key
```

## ✨ Best Practices Going Forward

✅ **DO:**
- Store secrets in `.env` file (gitignored)
- Use environment variables for API keys
- Keep `.env.example` with placeholder values
- Commit `.env.example` (for team reference)
- Regenerate keys if accidentally exposed

❌ **DON'T:**
- Commit API keys, passwords, tokens to git
- Upload Firebase config files to repositories
- Share API keys in code or comments
- Commit `.env` files with real values

## 🔑 Related Files to Check
- `android/app/google-services.json` - Keep local only
- `ios/GoogleService-Info.plist` - Keep local only
- `.env` - Keep local only, create from `.env.example`

## 📚 References
- [Firebase Security Best Practices](https://firebase.google.com/support/guides/firebase-android)
- [Git Security - Removing Sensitive Data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
- [12-Factor App - Config](https://12factor.net/config)

---

**Status:** ⚠️ API Key exposed - Needs immediate action from user to revoke in Firebase Console
