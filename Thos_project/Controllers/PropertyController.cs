using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Thos_project.DAL;
using Thos_project.Models;

namespace Thos_project.Controllers
{
    [AdminFilter]
    public class PropertyController : Controller
    {
        private ThosCafeTaskDB _context = new ThosCafeTaskDB();

        // Özellikleri listele
        public ActionResult Index()
        {
            var properties = _context.Property.ToList();
            return View(properties);
        }

        // Yeni özellik ekle
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Property property)
        {
            if (ModelState.IsValid)
            {
                _context.Property.Add(property);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(property);
        }

        // Özellik düzenle
        public ActionResult Edit(int id)
        {
            var property = _context.Property.Find(id);
            return View(property);
        }

  


        [HttpPost]
        public ActionResult Edit(int id, Property property)
        {
            if (ModelState.IsValid)
            {
                var existingCategory = _context.Property.Find(id); // ID'yi kullanarak mevcut kategoriyi bul
                if (existingCategory == null)
                {
                    return HttpNotFound(); // Kayıt bulunamazsa hata döndür
                }

                // Var olan kaydın değerlerini güncelle
                // Sadece diğer özellikleri güncelle
                existingCategory.Key = property.Key;
                existingCategory.Value = property.Value;

                // Diğer özellikleri de güncelle

                _context.SaveChanges(); // Değişiklikleri kaydet
                return RedirectToAction("Index");
            }
            return View(property); // Model geçerli değilse, formu tekrar göster
        }



        // Özellik sil
        public ActionResult Delete(int id)
        {
            var property = _context.Property.Find(id);
            return View(property);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            var property = _context.Property.Find(id);
            _context.Property.Remove(property);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}