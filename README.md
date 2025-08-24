# Free Download Manager for Fedora (RPM)

This project contains a script that downloads the official **Free Download Manager (FDM)** `.deb` package and converts it to a `.rpm` package for use in Fedora.

## 🚀 Usage
Clone the repository and run the script:
```bash
git clone https://github.com/victorsouzaleal/Free-Download-Manager-RPM.git
cd Free-Download-Manager-RPM
chmod +x build-rpm.sh
./build-rpm.sh
```

After execution, the .rpm package will be available in the current directory.
Installation example:
```bash
sudo dnf install ./freedownloadmanager-*.rpm
```

---
⚠️ **Legal notice**:
- This repository **does not distribute Free Download Manager**.  
- FDM is **proprietary** software and is subject to developer license:  
  👉 [https://www.freedownloadmanager.org/](https://www.freedownloadmanager.org/)  
- The script just automates the conversion of the official `.deb` installer to `.rpm`.  
- The original developer of FDM has **no relation** to this project.


The **fpm** utility, used for conversion, is free software under the MIT license.  
It is automatically installed by the script if necessary.
