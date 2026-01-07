# 🎬 MyKisah - Sistem Booking Tiket Bioskop

![PHP Badge](https://img.shields.io/badge/Language-PHP-blue?style=for-the-badge&logo=php)
![MySQL Badge](https://img.shields.io/badge/Database-MySQL-orange?style=for-the-badge&logo=mysql)

**MyKisah** adalah project **sistem pemesanan tiket bioskop berbasis web** yang berjalan **secara lokal (static local project)**.  
Project ini dibuat sebagai **tugas kuliah** dan dikembangkan menggunakan **PHP murni tanpa framework** serta **database MySQL**.

Aplikasi ini memiliki **dua peran utama**, yaitu **Admin** dan **User**, dengan fokus utama pada pengelolaan data dan proses pemesanan tiket.

Link Video Demo Progress Tubes - Responsi 2: https://youtu.be/8hDpreTAkj4


## ✨ Fitur

### 👤 User
- Registrasi dan Login
- Melihat daftar film
- Melihat detail film
- Memilih jadwal dan kursi
- Melakukan pembayaran
- Melihat konfirmasi pemesanan
- Melihat dan mengelola profil

### 🛠️ Admin
- Manage Movies
- Manage Schedules
- Manage Bookings
- Mengatur data hall/studio

---

## 🛠️ Teknologi yang Digunakan
- **Backend**: PHP Native (Tanpa Framework)
- **Database**: MySQL
- **Frontend**: HTML, CSS
- **Web Server**: Apache (XAMPP / Laragon)
- **Environment**: Localhost

---

## 📂 Struktur Folder

```text
├── cinema_booking.sql          # File database untuk di-import
├── DokumenSKPL...pdf           # Dokumentasi Software (SKPL/DFD)
├── README.md                   # File dokumentasi ini
└── MyKisah                     # Root folder aplikasi
    ├── admin/                  # Halaman khusus Administrator
    │   ├── manage-movies.php
    │   ├── manage-schedules.php
    │   └── ...
    ├── images/                 # Aset poster film
    ├── includes/               # File konfigurasi & koneksi DB
    │   └── config.php
    ├── index.php               # Halaman utama
    ├── login.php               # Halaman login
    ├── register.php            # Halaman daftar
    ├── movie-detail.php        # Detail film
    ├── select-seat.php         # Pemilihan kursi
    └── ...
```
# 🚀 Panduan Instalasi MyKisah

Dokumen ini berisi langkah-langkah lengkap untuk menginstal dan menjalankan aplikasi **MyKisah** di lingkungan pengembangan lokal (Localhost).

## 📋 Prasyarat Sistem

Sebelum memulai, pastikan komputer Anda telah terinstal software berikut:

1.  **Web Server & Database Server:**
    * Rekomendasi: **XAMPP** (Windows/Linux/Mac) atau **WAMP** (Windows).
    * PHP Versi: 7.4 atau lebih tinggi (rekomendasi PHP 8.0+).
    * MySQL/MariaDB.
2.  **Web Browser:** Google Chrome, Firefox, atau Edge.
3.  **Text Editor (Opsional):** VS Code atau Sublime Text (untuk mengedit konfigurasi jika diperlukan).

---

## ⚙️ Langkah-Langkah Instalasi

### Langkah 1: Persiapan Folder Proyek
1.  Unduh source code proyek ini (jika dalam bentuk ZIP, ekstrak terlebih dahulu).
2.  Salin folder **`MyKisah`** (yang berisi `index.php`, folder `admin`, `images`, dll).
3.  Tempelkan folder tersebut ke dalam direktori root server lokal Anda:
    * **XAMPP:** `C:\xampp\htdocs\`
4.  Pastikan struktur folder terlihat seperti ini: `C:\xampp\htdocs\MyKisah\`

### Langkah 2: Konfigurasi Database
1.  Nyalakan modul **Apache** dan **MySQL** pada control panel XAMPP Anda.
2.  Buka browser dan akses **phpMyAdmin**: `http://localhost/phpmyadmin/`
3.  Buat database baru:
    * Nama Database: **`cinema_booking`** (Penting: nama harus sesuai agar tidak perlu ubah kodingan).
    * Collation: `utf8mb4_general_ci` (Opsional, tapi disarankan).
4.  Pilih database yang baru dibuat, lalu klik tab **Import**.
5.  Klik **Choose File**, lalu cari file **`cinema_booking.sql`** yang ada di direktori utama repositori yang Anda unduh.
6.  Klik tombol **Go** atau **Kirim** di bagian bawah.
7.  Pastikan muncul pesan sukses ("Import has been successfully finished").

### Langkah 3: Konfigurasi Koneksi & URL
Buka file `MyKisah/includes/config.php` dengan text editor. Anda akan melihat bagian konfigurasi di baris paling atas. Sesuaikan bagian `define` dengan pengaturan server lokal Anda.

**Cari bagian ini di baris 3-10:**

```php
// Database Configuration
define('DB_HOST', 'localhost');
define('DB_USER', '');          // <--- Sesuaikan nama user dengan nama user XAMPP masing-masing
define('DB_PASS', '');          // <--- Sesuaikan Password dengan password XAMPP masing-masing
define('DB_NAME', 'cinema_booking');

// Site Configuration
define('SITE_NAME', 'MyKisah');
define('SITE_URL', 'https://localhost/MyKisah/'); // <--- Perhatikan protokol (http/https)
```
