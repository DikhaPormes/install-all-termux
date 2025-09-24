#!/data/data/com.termux/files/usr/bin/bash
# install-all-termux.sh
# Install sekumpulan paket populer di Termux (pkg, pip, npm)
# By Sayangmu ❤️
set -euo pipefail

echo "Mulai instalasi paket Termux. Pastikan koneksi internet OK dan storage cukup."
read -p "Lanjutkan? (y/n) " yn
if [[ "${yn,,}" != "y" ]]; then
  echo "Dibatalkan."
  exit 0
fi

# Update dasar
pkg update -y
pkg upgrade -y

# ----------------------------------------
# 1) Daftar paket Termux (pkg)
# Edit list ini sesuai kebutuhanmu
PKGS=(
  git
  curl
  wget
  proot
  proot-distro
  python
  python-dev
  nodejs
  openjdk-17
  clang
  make
  cmake
  autoconf
  automake
  pkg-config
  openssh
  rsync
  zip
  unzip
  tar
  grep
  sed
  awk
  coreutils
  busybox
  nano
  vim
  neovim
  tmux
  htop
  neofetch
  ffmpeg
  imagemagick
  aria2
  build-essential # beberapa termux build-* mungkin tidak tersedia; script akan skip jika tidak ada
)

echo ">>> Menginstall paket pkg (bisa memakan waktu)..."
for p in "${PKGS[@]}"; do
  echo "-> Menginstall: $p"
  pkg install -y "$p" || echo "(!) Gagal install $p — lanjut ke paket berikutnya"
done

# ----------------------------------------
# 2) Pip packages (global untuk python) — ubah/kurangi sesuai kebutuhan
PIPS=(
  --upgrade pip
  wheel
  setuptools
  youtube-dl
  yt-dlp
  moviepy
  requests
  pillow
  python-telegram-bot==13.15
  apscheduler
)

echo ">>> Menginstall paket pip..."
# pastikan pip dari python termux
python -m pip install --upgrade pip || true
for pkg in "${PIPS[@]}"; do
  echo "-> pip install: $pkg"
  python -m pip install "$pkg" || echo "(!) pip gagal install $pkg — lanjut"
done

# ----------------------------------------
# 3) NPM packages (global) — butuh nodejs sudah terpasang
NPMS=(
  pm2
  npx
)

echo ">>> Menginstall paket npm (global)..."
if command -v npm >/dev/null 2>&1; then
  for np in "${NPMS[@]}"; do
    echo "-> npm install -g $np"
    npm install -g "$np" || echo "(!) npm gagal install $np — lanjut"
  done
else
  echo "(!) npm tidak ditemukan — skip npm packages"
fi

# ----------------------------------------
# 4) Setup helper scripts / shortcuts (opsional)
echo "Membuat shortcut helper..."
cat > "$PREFIX/bin/start-ubuntu" <<'EOL'
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login ubuntu
EOL
chmod +x "$PREFIX/bin/start-ubuntu" || true

# ----------------------------------------
echo "Selesai. Beberapa catatan:"
echo "- Kalau muncul error 'package not found', itu berarti package tsb tidak tersedia di repo termux tertentu."
echo "- Periksa storage (df -h) jika instalasi gagal karena space."
echo "- Untuk remove paket yang nggak perlu: pkg uninstall <paket>"
echo "- Untuk pip uninstall: python -m pip uninstall <paket>"
echo
echo "✅ Semua langkah selesai. Coba restart Termux atau jalankan perintah yang kamu butuhkan."
