# install-all-termux

🔹 Penjelasan singkat

PKGS: paket Termux umum (developer tools, multimedia, utilitas). Edit sesuai kebutuhan.

PIPS: library Python (untuk bot, processing video, scraping, dsb).

NPMS: tool Node (pm2 untuk daemon/process manager).

Script robust terhadap kegagalan satu paket — akan lanjut ke paket berikutnya dan memberitahu jika gagal.



---

🔹 Tips aman & cepat

Cek storage dulu: df -h — hapus file besar jika perlu.

Jika ingin instal hanya kategori tertentu, cukup comment out bagian PKGS, PIPS, atau NPMS.

Hati-hati dengan paket besar (ffmpeg, openjdk) — butuh ruang.
