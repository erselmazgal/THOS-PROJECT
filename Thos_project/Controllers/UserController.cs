using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{
    [AdminFilter]
    public class UserController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // Kullanıcı listele
        public ActionResult Index()
        {
            var users = _context.User.ToList();
            return View(users);
        }

        // Yeni kullanıcı ekle
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(User user)
        {
            if (ModelState.IsValid)
            {
                user.SaltPassword = GenerateSalt();
                user.HashPassword = HashPassword(user.HashPassword, user.SaltPassword);
                _context.User.Add(user);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }
        public ActionResult Edit(int id)
        {
            var user = _context.User.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(User user,int id)
        {
            if (ModelState.IsValid)
            {
                // Şifre boş bırakılırsa, eski şifre korunur
                var existingUser = _context.User.Find(id);
                if (!string.IsNullOrWhiteSpace(user.HashPassword))
                {
                    // Yeni şifreyi hashleyip kaydedin
                    var salt = GenerateSalt();
                    existingUser.SaltPassword = salt;
                    existingUser.HashPassword = HashPassword(user.HashPassword, salt);
                }

                existingUser.Name = user.Name;
                existingUser.Surname = user.Surname;
                existingUser.UserName = user.UserName;

                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

    
        public ActionResult Delete(int id)
        {
            var user = _context.User.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var user = _context.User.Find(id);
            if (user != null)
            {
                _context.User.Remove(user);
                _context.SaveChanges();
            }
            return RedirectToAction("Index");
        }
        private string GenerateSalt()
        {
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);
            return Convert.ToBase64String(salt);
        }


        private string HashPassword(string password, string salt)
        {
            // Şifre hashleme metodu
            var sha256 = SHA256.Create();
            var saltedPassword = Encoding.UTF8.GetBytes(password + salt);
            return Convert.ToBase64String(sha256.ComputeHash(saltedPassword));
        }
    }
}