var express = require('express');
var router = express.Router();

const bcrypt = require('bcrypt');

router.post(`/login`, (req, res) => {
  req.getConnection((err, conn) => {
    conn.query(`select * from biodata where email = '${req.body.email}'`, (err, biodata) => {
      if (!biodata.length > 0) {
        console.log(err)
        req.flash('failedLoginMessage', `Email '${req.body.email}' tidak ditemukan !`)
        return res.redirect('/')
      }
      if (!bcrypt.compareSync(req.body.password, biodata[0].password)) {
        req.flash('failedLoginMessage',`Password yang Anda masukkan salah`);
        return res.redirect('/')
      }
      if (biodata[0].isAdmin) {
        req.session.user = biodata[0]
        res.redirect('/dashboard')
      }else{
        req.session.user = biodata[0]
        res.redirect('/pelamar')
      }
    })
  })
})

router.get('/register', function(req, res, next) {
  res.render('register', { 
      title: 'Register',
      registerMessage: req.flash("registerMessage"),
      failedRegisterMessage: req.flash("failedRegisterMessage")
     });
});

router.post('/register', (req, res) => {
  req.getConnection((err, conn) => {
    conn.query(`select * from biodata where email = '${req.body.email}'`, (err, bioAccount) => {
      if (bioAccount.length > 0) {
        req.flash(`failedRegisterMessage', 'Email '${req.body.email}' sudah digunakan, Silahkan gunakan email lain !`)
        return res.redirect('/users/register')
      }
      conn.query(`insert into biodata(id,email,password)values(null, '${req.body.email}','${bcrypt.hashSync(req.body.password,bcrypt.genSaltSync(8))}')`, (err, results) => {
        if (err) {
          console.log(err);
          req.flash(`failedRegisterMessage', 'Kesalahan saat melakukan Registrasi, pastikan semua field diisi dengan benar!`)
          return res.redirect('/users/register')
        }else{
          req.flash(`registerMessage', 'Register berhasil, silahkan LOGIN dengan mengklik tautan di bawah form !`)
          res.redirect('/users/register')
        }
      })
    })
  })
})

router.get('/logout', (req, res) => {
  req.session.destroy((err) => {
      res.redirect('/')
  })
})

module.exports = router;
