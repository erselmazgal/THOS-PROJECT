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
    public class LoginController : Controller
    {
        // GET: Login
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UserLogin(UserLoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = _context.User.FirstOrDefault(u => u.UserName == model.UserName);

                if (user != null && VerifyPassword(model.Password, user.HashPassword, user.SaltPassword))
                {
                    // Admin kullanıcı mı kontrol ediyoruz
                    if (user.UserName.ToLower() == "admin")
                    {
                        Session["IsAdmin"] = true;
                        return RedirectToAction("Index", "Dashboard");
                    }
                    else
                    {
                        Session["IsAdmin"] = false;
                        return RedirectToAction("Index", "ProductCustomer"); // Customer panel ekranı
                    }
                }
                ModelState.AddModelError("", "Geçersiz kullanıcı adı veya şifre.");
            }
            return View(model);
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }

        private bool VerifyPassword(string enteredPassword, string storedHash, string storedSalt)
        {
            var saltedPassword = enteredPassword + storedSalt;
            var hash = Convert.ToBase64String(SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(saltedPassword)));
            return hash == storedHash;
        }
    }
}