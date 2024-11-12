REPO="TooManyAcronymsInComputers/TMAICPM"
RELEASE_URL="https://github.com/$REPO/tmaicpm.tar.gz"
TEMP_DIR="/tmp/tmaicpm"
INSTALL_DIR="$HOME/TMAICPM"   
DESKTOP_DIR="$HOME/.local/share/applications"  
ICON_DIR="$HOME/.local/share/icons"             
BIN_DEST="$HOME/.local/bin"    
DESKTOP_FILE="$DESKTOP_DIR/TMAICPM.desktop"

echo_message() {
    echo "[INFO] $1"
}

echo_message "Checking for required dependencies..."
if ! command -v curl &>/dev/null; then
    echo_message "curl not found, installing..."
    sudo apt-get install -y curl
fi
if ! command -v tar &>/dev/null; then
    echo_message "tar not found, installing..."
    sudo apt-get install -y tar
fi
if ! command -v python3 &>/dev/null; then
    echo_message "python3 not found, installing..."
    sudo apt-get install -y python3
fi
if ! command -v pip3 &>/dev/null; then
    echo_message "pip3 not found, installing..."
    sudo apt-get install -y python3-pip
fi

echo_message "Creating necessary directories..."
mkdir -p "$TEMP_DIR" "$INSTALL_DIR" "$ICON_DIR/TMAICPM" "$DESKTOP_DIR" "$BIN_DEST"
echo_message "Do you want to download the latest release from GitHub or use local files?"
select OPTION in "Download from GitHub" "Use local files"; do
    case $OPTION in
        "Download from GitHub")
            echo_message "Downloading the latest release from GitHub..."
            curl -L "$RELEASE_URL" -o "$TEMP_DIR/tmaicpm.tar.gz"
            echo_message "Extracting downloaded archive..."
            tar -xvzf "$TEMP_DIR/tmaicpm.tar.gz" -C "$TEMP_DIR"
            break
            ;;
        "Use local files")
            echo_message "Please ensure the application files are in the current directory."
            break
            ;;
        *)
            echo_message "Invalid option. Please choose 1 for GitHub download or 2 for local files."
            ;;
    esac
done

if [ ! -d "$TEMP_DIR/tmaicpm" ]; then
    echo_message "Error: The application files were not found. Please make sure the files are in the current directory."
    exit 1
fi

echo_message "Copying application files..."
cp -r "$TEMP_DIR/tmaicpm"/* "$INSTALL_DIR/"
cp "$INSTALL_DIR/icons/TL.png" "$ICON_DIR/TMAICPM/"
cp "$INSTALL_DIR/dist/my_app" "$BIN_DEST/"
chmod +x "$BIN_DEST/my_app"

if [ -f "$INSTALL_DIR/requirements.txt" ]; then
    echo_message "Installing Python dependencies from requirements.txt..."
    pip3 install -r "$INSTALL_DIR/requirements.txt"
else
    echo_message "No requirements.txt found, skipping Python dependency installation."
fi

echo_message "Creating .desktop entry..."
if [ ! -f "$DESKTOP_FILE" ]; then
    echo "[Desktop Entry]" > "$DESKTOP_FILE"
    echo "Version=1.0" >> "$DESKTOP_FILE"
    echo "Name=My Python App" >> "$DESKTOP_FILE"
    echo "Comment=This is a description of my Python application." >> "$DESKTOP_FILE"
    echo "Exec=$BIN_DEST/my_app" >> "$DESKTOP_FILE"
    echo "Icon=$ICON_DIR/TMAICPM/TL.png" >> "$DESKTOP_FILE"
    echo "Terminal=false" >> "$DESKTOP_FILE"
    echo "Type=Application" >> "$DESKTOP_FILE"
    echo "Categories=Utility;Development;" >> "$DESKTOP_FILE"
fi

chmod +x "$DESKTOP_FILE"

if [ -d "$TEMP_DIR/tmaicpm" ]; then
    rm -rf "$TEMP_DIR"
fi

echo_message "Installation complete! You can now launch the app from your application menu."
