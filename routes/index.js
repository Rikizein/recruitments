var express = require('express');
var router = express.Router();

const bcrypt = require('bcrypt');

/* check session. */
sessionChecker = (req, res, next) => {
  if (req.session.user) {
    next()
  } else {
    req.flash("sessionMessage", "Sesi Anda sudah berakhir, silahkan login kembali !")
    res.redirect('/')
  }
}

/* check Admin. */
adminChecker = (req, res, next) => {
  if (req.session.user && req.session.user.isAdmin) {
    next()
  } else {
    req.flash("adminMessage", "Admin Only!")
    res.redirect('/')
  }
}

/* GET home page. */
router.get('/', (req, res, next) => {
  res.render('login', {
    title: 'Login',
    loginMessage: req.flash("loginMessage"),
    failedLoginMessage: req.flash("failedLoginMessage"),
    messageSession: req.flash("sessionMessage")
  });
});

/* GET Dashboard page. */
router.get('/dashboard', sessionChecker, adminChecker, (req, res) => {
  req.getConnection((err, conn) => {
    conn.query(`select * from biodata where isAdmin = 0`, (err, data) => {
      conn.query(`select count(*) as count from biodata where isAdmin = 0`, (err, count) => {
        conn.query(`select count(*) as staff from vbiodata where isAdmin = 0 and posisi = 'Staff'`, (err, staff) => {
          conn.query(`select count(*) as spv from vbiodata where isAdmin = 0 and posisi = 'Supervisor'`, (err, spv) => {
            conn.query(`select count(*) as mgr from vbiodata where isAdmin = 0 and posisi = 'Manager'`, (err, mgr) => {
              res.render('dashboard', {
                title: "Dashboard",
                data: data,
                count:count[0],
                staff:staff[0],
                spv:spv[0],
                mgr:mgr[0],
                user: req.session.user
              })
            })
          })
        })
      })
    })
  })
})

/* GET biodata. */
router.get('/biodata', sessionChecker, (req, res) => {
  res.render('biodata', {
    title: "Biodata",
    user: req.session.user
  })
})

/* GET data pelamar. */
// router.get('/pelamar', sessionChecker, (req, res) => {
//   let userId = req.session.user.id
//   req.getConnection((err, conn) => {
//     conn.query(`select * from biodata where id = ?`, [userId], (err, data) => {
//       conn.query(`select * from riwayat_pendidikan where id_bio = ?`, [userId], (err, datarpd) => {
//         conn.query(`select * from riwayat_pelatihan where id_bio = ?`, [userId], (err, datarpl) => {
//           conn.query(`select * from riwayat_pekerjaan where id_bio = ?`, [userId], (err, datarpk) => {
//             conn.query(`select * from lamaran where id_pelamar = ?`, [userId], (err, datalamar) => {
//               res.render('pelamar', {
//                 title: "Pelamar",
//                 data: data[0],
//                 datarpd: datarpd[0],
//                 datarpl: datarpl[0],
//                 datarpk: datarpk[0],
//                 datalamar: datalamar[0],
//                 user: req.session.user
//               })
//             })
//           })
//         })
//       })
//     })
//   })
// })

router.get('/pelamar', sessionChecker, (req, res) => {
  let userId = req.session.user.id
  req.getConnection((err, conn) => {
    conn.query(`select * from vbiodata where id = ?`, [userId], (err, data) => {
      res.render('pelamarBu', {
        title:"Pelamar",
        data:data[0],
        user:req.session.user
      })
    })
  })
})



router.get('/update/:id', (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    conn.query(`select * from biodata where id = ?`, [id], (err, data) => {
      conn.query(`select * from riwayat_pendidikan where id_bio = ?`, [id], (err, datarpd) => {
        conn.query(`select * from riwayat_pelatihan where id_bio = ?`, [id], (err, datarpl) => {
          conn.query(`select * from riwayat_pekerjaan where id_bio = ?`, [id], (err, datarpk) => {
            res.render('updateBio', {
              title: "Update Biodata",
              data: data[0],
              datarpd: datarpd[0],
              datarpl: datarpl[0],
              datarpk: datarpk[0],
              user: req.session.user
            })
          })
        })
      })
    })
  })
})

router.post('/update', (req, res) => {
  // const { id, id_bio } = req.params;
  let userId = req.session.user.id
  req.getConnection((err, conn) => {
    conn.query(`update biodata set nama = '${req.body.nama}', alamat = '${req.body.alamat}', tempatLahir = '${req.body.tempatLahir}', 
    tglLahir = '${req.body.tglLahir}', hp = '${req.body.hp}', gender = '${req.body.gender}' where id = ?`, [userId], (err, result) => {
      if (err) {
        console.log(err);
      }
      conn.query(`REPLACE INTO riwayat_pendidikan(id,id_bio,jenjang,namaSekolah,kota,thMulai,thLulus,jurusan)VALUES
      (null,'${req.body.id_bio}','${req.body.jenjang}','${req.body.namaSekolah}','${req.body.kota}','${req.body.thMulai}',
      '${req.body.thLulus}','${req.body.jurusan}')`, (err, results) => {
        if (err) {
          console.log(err);
        }
        conn.query(`REPLACE INTO riwayat_pelatihan(id,id_bio,namaKursus,penyelenggara,tahun,tempat)VALUES
      (null,'${req.body.id_bio}','${req.body.namaKursus}','${req.body.penyelenggara}','${req.body.tahun}','${req.body.tempat}')`, (err, results) => {
          if (err) {
            console.log(err);
          }
          conn.query(`REPLACE INTO riwayat_pekerjaan(id,id_bio,namaPerusahaan,alamatPerusahaan,bidang,jabatan,dariTh,sampaiTh)VALUES
      (null,'${req.body.id_bio}','${req.body.namaPerusahaan}','${req.body.alamatPerusahaan}','${req.body.bidang}','${req.body.jabatan}',
      '${req.body.dariTh}','${req.body.sampaiTh}')`, (err, results) => {
            if (err) {
              console.log(err);
            }
            res.redirect('/pelamar')
          })
        })
      })
    })
  })
})

router.get('/lamaran_masuk', (req, res) => {
  req.getConnection((err, conn) => {
    conn.query(`select * from vbiodata where isAdmin = 0`, (err, data) => {
      res.render('lamaran_masuk', {
        title:"Lamaran Masuk",
        data:data,
        user:req.session.user
      })
    })
  })
})

router.get('/profile/:id', sessionChecker, (req, res) => {
  let {id} = req.params;
  req.getConnection((err, conn) => {
    conn.query(`select * from vbiodata where id = ?`, [id], (err, data) => {
      console.log("data", data);
      res.render('profile', {
        title:"Profile",
        data:data[0],
        user:req.session.user
      })
    })
  })
})



module.exports = router;
