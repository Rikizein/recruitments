-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Sep 2021 pada 10.26
-- Versi server: 10.1.34-MariaDB
-- Versi PHP: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recruitments`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `biodata`
--

CREATE TABLE `biodata` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `tempatLahir` varchar(50) NOT NULL,
  `tglLahir` date DEFAULT NULL,
  `hp` varchar(20) NOT NULL,
  `gender` char(2) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(225) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `biodata`
--

INSERT INTO `biodata` (`id`, `nama`, `alamat`, `tempatLahir`, `tglLahir`, `hp`, `gender`, `email`, `password`, `isAdmin`) VALUES
(1, 'Riki Hidayat', 'jl. cisaranten wetan', 'Bandung', '2021-09-11', '0897865432', 'L', 'riki@riki', '$2b$08$GjeTVQVGf4LHi00rYizoXu78OPtdyWxzJZaA5cHaYnLEhXhul.NA2', 0),
(2, '', '', '', '0000-00-00', '', '', 'admin@admin', '$2b$08$UM68vUWPnnNKxi3HpXCreuHFQ4XmT9czKdG615RlOmLUzDmd3H2MK', 1),
(3, 'Hanan Fathiya', 'jl. cisaranten wetan', 'Bandung', '2021-06-23', '67890456789', 'P', 'hanan@hanan', '$2b$08$cKDSRsb2Rimr.FJAA8PE/evaVjqK8br74E46x1IJ.pyyP1sTFTQX2', 0),
(7, 'Agus', 'Cilisung', 'Garut', '1984-02-11', '09876543', 'L,', 'agus@agus', '$2b$08$gj/1uod/NFGYxYK4U47a6./u2.Ni4Yshpm22dt/1bt5Gd06HiQmqW', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lamaran`
--

CREATE TABLE `lamaran` (
  `id` int(11) NOT NULL,
  `id_pelamar` int(11) NOT NULL,
  `posisi` varchar(30) NOT NULL,
  `status` char(2) NOT NULL,
  `isApply` tinyint(1) NOT NULL,
  `tanggal_apply` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `lamaran`
--

INSERT INTO `lamaran` (`id`, `id_pelamar`, `posisi`, `status`, `isApply`, `tanggal_apply`) VALUES
(1, 1, 'Manager', '', 0, '0000-00-00'),
(2, 3, 'Supervisor', '', 0, '0000-00-00'),
(3, 7, 'Staff', '', 0, '0000-00-00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_pekerjaan`
--

CREATE TABLE `riwayat_pekerjaan` (
  `id` int(11) NOT NULL,
  `id_bio` int(11) NOT NULL,
  `namaPerusahaan` varchar(100) NOT NULL,
  `alamatPerusahaan` text NOT NULL,
  `bidang` varchar(50) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `dariTh` varchar(10) NOT NULL,
  `sampaiTh` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `riwayat_pekerjaan`
--

INSERT INTO `riwayat_pekerjaan` (`id`, `id_bio`, `namaPerusahaan`, `alamatPerusahaan`, `bidang`, `jabatan`, `dariTh`, `sampaiTh`) VALUES
(1, 1, 'MCM', 'Jl.cibaduyut', 'Fashion', 'SVP', '2008', '2021'),
(2, 3, 'Software House', 'jl. cisaranten wetan', 'Software', 'SVP', '2008', '2021'),
(4, 7, 'PT. Makmur', 'Cigondewah', 'Desain grafis', 'Staff', '2019', '2021');

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_pelatihan`
--

CREATE TABLE `riwayat_pelatihan` (
  `id` int(11) NOT NULL,
  `id_bio` int(11) NOT NULL,
  `namaKursus` varchar(100) NOT NULL,
  `penyelenggara` varchar(100) NOT NULL,
  `tahun` varchar(10) NOT NULL,
  `tempat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `riwayat_pelatihan`
--

INSERT INTO `riwayat_pelatihan` (`id`, `id_bio`, `namaKursus`, `penyelenggara`, `tahun`, `tempat`) VALUES
(1, 1, 'Web Design', 'Rubicamp', '2017', 'Bandung'),
(2, 3, 'Web Design', 'COdago', '2019', 'Bandung'),
(4, 7, 'Deain grafis', 'CV. Berkayra', '2019', 'Bandung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_pendidikan`
--

CREATE TABLE `riwayat_pendidikan` (
  `id` int(11) NOT NULL,
  `id_bio` int(11) NOT NULL,
  `jenjang` varchar(10) NOT NULL,
  `namaSekolah` varchar(50) NOT NULL,
  `kota` varchar(50) NOT NULL,
  `thMulai` varchar(10) NOT NULL,
  `thLulus` varchar(10) NOT NULL,
  `jurusan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `riwayat_pendidikan`
--

INSERT INTO `riwayat_pendidikan` (`id`, `id_bio`, `jenjang`, `namaSekolah`, `kota`, `thMulai`, `thLulus`, `jurusan`) VALUES
(3, 1, 'SLTA', 'BINA HARAPAN', 'Bandung', '1991', '1994', 'IPS'),
(4, 3, 'S1', 'UIN', 'Bandung', '2019', '2021', 'MANAGEMENT'),
(6, 7, 'SMA', 'CISKUL', 'Bandung', '1991', '1994', 'IPS');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vbiodata`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vbiodata` (
`id` int(11)
,`nama` varchar(100)
,`alamat` text
,`tempatLahir` varchar(50)
,`tglLahir` date
,`hp` varchar(20)
,`gender` char(2)
,`email` varchar(50)
,`isAdmin` tinyint(1)
,`jenjang` varchar(10)
,`namaSekolah` varchar(50)
,`kota` varchar(50)
,`thMulai` varchar(10)
,`thLulus` varchar(10)
,`jurusan` varchar(50)
,`namaKursus` varchar(100)
,`penyelenggara` varchar(100)
,`tahun` varchar(10)
,`tempat` varchar(100)
,`namaPerusahaan` varchar(100)
,`alamatPerusahaan` text
,`bidang` varchar(50)
,`jabatan` varchar(50)
,`dariTh` varchar(10)
,`sampaiTh` varchar(10)
,`posisi` varchar(30)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `vbiodata`
--
DROP TABLE IF EXISTS `vbiodata`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vbiodata`  AS  select `biodata`.`id` AS `id`,`biodata`.`nama` AS `nama`,`biodata`.`alamat` AS `alamat`,`biodata`.`tempatLahir` AS `tempatLahir`,`biodata`.`tglLahir` AS `tglLahir`,`biodata`.`hp` AS `hp`,`biodata`.`gender` AS `gender`,`biodata`.`email` AS `email`,`biodata`.`isAdmin` AS `isAdmin`,`riwayat_pendidikan`.`jenjang` AS `jenjang`,`riwayat_pendidikan`.`namaSekolah` AS `namaSekolah`,`riwayat_pendidikan`.`kota` AS `kota`,`riwayat_pendidikan`.`thMulai` AS `thMulai`,`riwayat_pendidikan`.`thLulus` AS `thLulus`,`riwayat_pendidikan`.`jurusan` AS `jurusan`,`riwayat_pelatihan`.`namaKursus` AS `namaKursus`,`riwayat_pelatihan`.`penyelenggara` AS `penyelenggara`,`riwayat_pelatihan`.`tahun` AS `tahun`,`riwayat_pelatihan`.`tempat` AS `tempat`,`riwayat_pekerjaan`.`namaPerusahaan` AS `namaPerusahaan`,`riwayat_pekerjaan`.`alamatPerusahaan` AS `alamatPerusahaan`,`riwayat_pekerjaan`.`bidang` AS `bidang`,`riwayat_pekerjaan`.`jabatan` AS `jabatan`,`riwayat_pekerjaan`.`dariTh` AS `dariTh`,`riwayat_pekerjaan`.`sampaiTh` AS `sampaiTh`,`lamaran`.`posisi` AS `posisi` from ((((`biodata` join `riwayat_pendidikan`) join `riwayat_pelatihan`) join `riwayat_pekerjaan`) join `lamaran`) where ((`riwayat_pendidikan`.`id_bio` = `biodata`.`id`) and (`riwayat_pelatihan`.`id_bio` = `biodata`.`id`) and (`riwayat_pekerjaan`.`id_bio` = `biodata`.`id`) and (`lamaran`.`id_pelamar` = `biodata`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `biodata`
--
ALTER TABLE `biodata`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lamaran`
--
ALTER TABLE `lamaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pelamar` (`id_pelamar`);

--
-- Indeks untuk tabel `riwayat_pekerjaan`
--
ALTER TABLE `riwayat_pekerjaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_bio` (`id_bio`);

--
-- Indeks untuk tabel `riwayat_pelatihan`
--
ALTER TABLE `riwayat_pelatihan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_bio` (`id_bio`);

--
-- Indeks untuk tabel `riwayat_pendidikan`
--
ALTER TABLE `riwayat_pendidikan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_bio` (`id_bio`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `biodata`
--
ALTER TABLE `biodata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `lamaran`
--
ALTER TABLE `lamaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `riwayat_pekerjaan`
--
ALTER TABLE `riwayat_pekerjaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `riwayat_pelatihan`
--
ALTER TABLE `riwayat_pelatihan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `riwayat_pendidikan`
--
ALTER TABLE `riwayat_pendidikan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `lamaran`
--
ALTER TABLE `lamaran`
  ADD CONSTRAINT `lamaran_ibfk_1` FOREIGN KEY (`id_pelamar`) REFERENCES `biodata` (`id`);

--
-- Ketidakleluasaan untuk tabel `riwayat_pekerjaan`
--
ALTER TABLE `riwayat_pekerjaan`
  ADD CONSTRAINT `riwayat_pekerjaan_ibfk_1` FOREIGN KEY (`id_bio`) REFERENCES `biodata` (`id`);

--
-- Ketidakleluasaan untuk tabel `riwayat_pelatihan`
--
ALTER TABLE `riwayat_pelatihan`
  ADD CONSTRAINT `riwayat_pelatihan_ibfk_1` FOREIGN KEY (`id_bio`) REFERENCES `biodata` (`id`);

--
-- Ketidakleluasaan untuk tabel `riwayat_pendidikan`
--
ALTER TABLE `riwayat_pendidikan`
  ADD CONSTRAINT `riwayat_pendidikan_ibfk_1` FOREIGN KEY (`id_bio`) REFERENCES `biodata` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
