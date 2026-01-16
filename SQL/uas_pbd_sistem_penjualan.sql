CREATE DATABASE uas_pbd_penjualan;

USE uas_pbd_penjualan;

CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100)
);

CREATE TABLE toko (
    id_toko INT AUTO_INCREMENT PRIMARY KEY,
    nama_toko VARCHAR(100),
    npwp VARCHAR(50),
    telp VARCHAR(20)
);

CREATE TABLE kasir (
    id_kasir INT AUTO_INCREMENT PRIMARY KEY,
    nama_kasir VARCHAR(100),
    username_kasir VARCHAR(50),
    password_kasir VARCHAR(100)
);

CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100),
    satuan_produk VARCHAR(50)
);

CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    no_struk INT UNIQUE,
    tgl_transaksi DATE,
    id_pelanggan INT,
    id_toko INT,
    id_kasir INT,

    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_toko) REFERENCES toko(id_toko),
    FOREIGN KEY (id_kasir) REFERENCES kasir(id_kasir)
);

CREATE TABLE detail_transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_produk INT,
    harga_satuan DECIMAL(10,2),
    qty INT,
    subtotal DECIMAL(10,2),

    FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi),
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
);

INSERT INTO pelanggan (nama_pelanggan)
VALUES ('NURMA');

INSERT INTO toko (nama_toko, npwp, telp)
VALUES ('CV Lestari Sukses Makmur', '71.057.920.2-532.000', '620479');

INSERT INTO kasir (nama_kasir, username_kasir, password_kasir)
VALUES ('Siti', 'siti01', '12345');

INSERT INTO produk (nama_produk, satuan_produk)
VALUES 
('Boncabe Makaroni', 'pax'),
('Criscito', 'pax'),
('Potakrezzz', 'pax');

START TRANSACTION;

INSERT INTO transaksi (no_struk, tgl_transaksi, id_pelanggan, id_toko, id_kasir)
VALUES (503837, '2025-06-12', 1, 1, 1);

COMMIT;

INSERT INTO detail_transaksi (id_transaksi, id_produk, harga_satuan, qty, subtotal)
VALUES
(1, 1, 7400, 2, 14800),
(1, 2, 8200, 3, 24600),
(1, 3, 7450, 2, 14900);

SELECT * FROM produk;


SELECT p.nama_pelanggan, t.no_struk, t.tgl_transaksi
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan;

SELECT id_produk, SUM(qty) AS total_terjual
FROM detail_transaksi
GROUP BY id_produk;

SELECT 
    p.id_produk,
    p.nama_produk,
    SUM(d.qty) AS total_terjual
FROM detail_transaksi d
JOIN produk p ON d.id_produk = p.id_produk
GROUP BY p.id_produk, p.nama_produk;

SELECT id_produk, SUM(subtotal) AS total_penjualan
FROM detail_transaksi
GROUP BY id_produk
HAVING total_penjualan > 20000;
